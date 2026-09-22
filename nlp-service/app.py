from fastapi import FastAPI
from pydantic import BaseModel
from typing import Dict, List
import re
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from sentence_transformers import SentenceTransformer

app = FastAPI(title="SangKien NLP")

print("⏳ Đang tải model vietnamese-bi-encoder (lần đầu mất vài phút)...")
model = SentenceTransformer("bkai-foundation-models/vietnamese-bi-encoder")
print("✅ Model đã sẵn sàng!")


def normalize(t: str) -> str:
    return re.sub(r"\s+", " ", (t or "")).lower().strip()


def split_sentences(text: str) -> List[str]:
    parts = re.split(r"(?<=[.!?…])\s+|\n{2,}", text or "")
    return [p.strip() for p in parts if len(p.strip()) >= 20]


def jaccard(a: str, b: str) -> float:
    sa, sb = set(normalize(a).split()), set(normalize(b).split())
    if not sa or not sb:
        return 0.0
    return len(sa & sb) / len(sa | sb)


def tfidf_cos(a: str, b: str) -> float:
    if not a.strip() or not b.strip():
        return 0.0
    v = TfidfVectorizer(analyzer="word", ngram_range=(1, 2), sublinear_tf=True)
    m = v.fit_transform([normalize(a), normalize(b)])
    return float(cosine_similarity(m[0:1], m[1:2])[0][0])


def cosine_pair(a: str, b: str) -> float:
    """Tính cosine similarity giữa 2 string."""
    if not a.strip() or not b.strip():
        return 0.0
    vecs = model.encode([a, b], normalize_embeddings=True, batch_size=2)
    return float(np.dot(vecs[0], vecs[1]))


class CompareReq(BaseModel):
    text_a: str
    text_b: str


class SectionsReq(BaseModel):
    sections_a: Dict[str, str]
    sections_b: Dict[str, str]


@app.get("/health")
def health():
    return {"ok": True}


@app.post("/compare")
def compare(req: CompareReq):
    j = jaccard(req.text_a, req.text_b)
    t = tfidf_cos(req.text_a, req.text_b)
    e = cosine_pair(req.text_a, req.text_b)
    score = 0.15 * j + 0.25 * t + 0.60 * e
    return {
        "score": round(score * 100, 2),
        "lexical": round(j * 100, 2),
        "tfidf": round(t * 100, 2),
        "semantic": round(e * 100, 2),
    }


@app.post("/compare-sections")
def compare_sections(req: SectionsReq):
    out = {}
    for key in req.sections_a.keys():
        a = (req.sections_a.get(key) or "").strip()
        b = (req.sections_b.get(key) or "").strip()

        if not a or not b:
            out[key] = {"score": 0.0, "pairs": []}
            continue

        # Điểm cấp phần
        e_part = cosine_pair(a, b)
        t_part = tfidf_cos(a, b)
        section_score = 0.75 * e_part + 0.25 * t_part

        # Cặp câu giống nhất
        sents_a = split_sentences(a)
        sents_b = split_sentences(b)
        pairs = []

        if sents_a and sents_b:
            emb_a = model.encode(sents_a, normalize_embeddings=True, batch_size=32)
            emb_b = model.encode(sents_b, normalize_embeddings=True, batch_size=32)
            sim = emb_a @ emb_b.T  # ma trận (len_a x len_b)

            used = set()
            for i, sa in enumerate(sents_a):
                order = np.argsort(-sim[i])
                j = int(order[0])
                for cand in order:
                    if int(cand) not in used:
                        j = int(cand)
                        break
                used.add(j)
                pairs.append({
                    "a": sa,
                    "b": sents_b[j],
                    "score": round(float(sim[i][j]) * 100, 2),
                })

        out[key] = {
            "score": round(section_score * 100, 2),
            "pairs": pairs,
        }
    return out