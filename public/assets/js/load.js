// Wrapper fetch JSON
window.api = async function (url, opts = {}) {
  const res = await fetch(url, {
    headers: { 'Content-Type': 'application/json' },
    ...opts,
    body: opts.body ? JSON.stringify(opts.body) : undefined,
  });
  const data = await res.json().catch(() => ({ success: false, error: 'Bad JSON' }));
  if (!data.success) throw new Error(data.error || `HTTP ${res.status}`);
  return data.data;
};

window.escapeHtml = (s) =>
  String(s ?? '').replace(/[&<>"']/g, (c) =>
    ({ '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;' }[c]));

window.classifyByScore = (s) => {
  if (s >= 85) return { label:'Trùng cao',      color:'#dc2626', bg:'#fee2e2', emoji:'🔴', level:'RAT_CAO' };
  if (s >= 70) return { label:'Tương đồng cao', color:'#f97316', bg:'#ffedd5', emoji:'🟠', level:'CAO' };
  if (s >= 50) return { label:'Tương đồng',     color:'#eab308', bg:'#fef9c3', emoji:'🟡', level:'TRUNG_BINH' };
  return              { label:'Khác biệt',      color:'#16a34a', bg:'#dcfce7', emoji:'🟢', level:'THAP' };
};

// Highlight n-gram dài (>=3 từ) chung giữa 2 câu
window.highlightCommon = function (text, other) {
  if (!other) return escapeHtml(text);
  const otherTokens = other.toLowerCase().split(/\s+/);
  const grams = new Set();
  for (let i = 0; i + 3 <= otherTokens.length; i++) {
    grams.add(otherTokens.slice(i, i + 3).join(' '));
  }
  let html = escapeHtml(text);
  const list = [...grams].filter(g => g.length >= 15)
    .sort((a,b)=>b.length-a.length).slice(0, 60);
  for (const g of list) {
    const safe = g.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const re = new RegExp(`(${safe})`, 'gi');
    html = html.replace(re, '<mark class="hl">$1</mark>');
  }
  return html;
};

let sangKienList = [];

// =====================================================
// LOAD DANH MỤC
// =====================================================

async function loadDanhMuc() {
  const dm = await api('../api/danh-muc-list.php');

  const selNam = document.getElementById('filterNam');

  selNam.innerHTML = dm.nam
    .map(n => `
      <option value="${n.id}">
        Năm ${n.nam}
      </option>
    `)
    .join('');

  const selLv = document.getElementById('filterLinhVuc');

  selLv.innerHTML =
    '<option value="0">-- Tất cả --</option>' +
    dm.linh_vuc
      .map(l => `
        <option value="${l.id}">
          ${escapeHtml(l.ten)}
        </option>
      `)
      .join('');
}

// =====================================================
// LOAD DANH SÁCH SÁNG KIẾN
// =====================================================

async function loadSangKien() {

  const tbody = document.getElementById('ideaTableBody');
  const resultBox = document.getElementById('resultBox');
  const alertBox = document.getElementById('alertBox');

  try {

    const nam =
      document.getElementById('filterNam').value || 0;

    const lv =
      document.getElementById('filterLinhVuc').value || 0;

    const q =
      document.getElementById('searchQ').value.trim();

    const url =
      `../api/sang-kien-list.php` +
      `?nam_id=${encodeURIComponent(nam)}` +
      `&linh_vuc_id=${encodeURIComponent(lv)}` +
      `&q=${encodeURIComponent(q)}`;

    // api() đã trả về data.data
    const data = await api(url);

    sangKienList = Array.isArray(data) ? data : [];

    if (!sangKienList.length) {

      tbody.innerHTML = `
        <tr>
          <td colspan="6" class="empty-table">
            <i class="bi bi-inbox"></i>
            <div>Không tìm thấy sáng kiến nào.</div>
          </td>
        </tr>
      `;

      resetSelection();
      return;
    }

    tbody.innerHTML = sangKienList.map(s => `
      <tr>

        <td class="text-center">
          <input
            type="checkbox"
            class="idea-check idea-check-item"
            value="${escapeHtml(String(s.id ?? ''))}"
          >
        </td>

        <td>
          <span class="idea-code">
            ${escapeHtml(String(s.ma ?? ''))}
          </span>
        </td>

        <td>
          <div class="idea-name">
            ${escapeHtml(String(s.ten ?? ''))}
          </div>
        </td>

        <td>
          <span class="idea-field">
            ${escapeHtml(String(s.ten_linh_vuc ?? ''))}
          </span>
        </td>

        <td>
          <span class="idea-year">
            ${escapeHtml(String(s.nam ?? ''))}
          </span>
        </td>

        <td>
          <span class="status-badge">
            Có dữ liệu
          </span>
        </td>

      </tr>
    `).join('');

    resetSelection();

    if (resultBox) {
      resultBox.innerHTML = '';
    }

    if (alertBox) {
      alertBox.innerHTML = '';
    }

  } catch (error) {

    console.error('loadSangKien:', error);

    sangKienList = [];

    tbody.innerHTML = `
      <tr>
        <td colspan="6" class="empty-table">

          <i class="bi bi-exclamation-triangle text-danger"></i>

          <div class="text-danger fw-semibold">
            Không thể tải danh sách sáng kiến.
          </div>

          <small class="text-muted">
            ${escapeHtml(error.message || '')}
          </small>

        </td>
      </tr>
    `;

    if (alertBox) {
      alertBox.innerHTML = `
        <div class="alert alert-danger border-0 shadow-sm">

          <i class="bi bi-exclamation-circle me-2"></i>

          Lỗi khi tải danh sách sáng kiến:

          <strong>
            ${escapeHtml(error.message || 'Không xác định')}
          </strong>

        </div>
      `;
    }
  }
}