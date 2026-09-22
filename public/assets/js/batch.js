document.addEventListener('DOMContentLoaded', async () => {
  const dm = await api('../api/danh-muc-list.php');
  document.getElementById('batchNam').innerHTML =
    dm.nam.map(n => `<option value="${n.id}">Năm ${n.nam}</option>`).join('');
  document.getElementById('batchLinhVuc').innerHTML =
    '<option value="0">-- Tất cả --</option>' +
    dm.linh_vuc.map(l => `<option value="${l.id}">${l.ten}</option>`).join('');

  document.getElementById('btnRun').onclick    = onRunBatch;
  document.getElementById('btnReload').onclick = loadDots;
  await loadDots();
});

async function onRunBatch() {
  const nam = +document.getElementById('batchNam').value;
  const lv  = +document.getElementById('batchLinhVuc').value || 0;
  if (!nam) return;

  const msg = document.getElementById('batchMsg');
  msg.innerHTML = `<div class="alert alert-info py-2 mb-0">
    <span class="spinner-border spinner-border-sm"></span>
    Đang chạy, vui lòng đợi... Có thể mất vài phút nếu nhiều sáng kiến.
  </div>`;

  const btn = document.getElementById('btnRun');
  btn.disabled = true;

  try {
    const body = { nam_id: nam };
    if (lv) body.linh_vuc_id = lv;
    const r = await api('../api/kiem-tra-trung-check-batch.php', { method: 'POST', body });
    msg.innerHTML = `<div class="alert alert-success py-2 mb-0">
      ✅ Hoàn tất! Đợt #${r.dot_id}
    </div>`;
    await loadDots();
    showDot(r.dot_id);
  } catch (e) {
    msg.innerHTML = `<div class="alert alert-danger py-2 mb-0">Lỗi: ${escapeHtml(e.message)}</div>`;
  } finally {
    btn.disabled = false;
  }
}

async function loadDots() {
  const list = await api('../api/kiem-tra-trung-dot-list.php');
  const box = document.getElementById('dotList');

  if (!list.length) {
    box.innerHTML = '<div class="list-group-item text-muted small">Chưa có dữ liệu</div>';
    return;
  }

  box.innerHTML = list.map(d => {
    const badge = {
      CHO_XU_LY:'secondary', DANG_XU_LY:'warning', HOAN_TAT:'success', LOI:'danger'
    }[d.trang_thai] || 'secondary';
    return `<button class="list-group-item list-group-item-action" data-id="${d.id}">
      <div class="d-flex justify-content-between">
        <strong>Đợt #${d.id}</strong>
        <span class="badge bg-${badge}">${d.trang_thai}</span>
      </div>
      <div class="small text-muted">
        ${d.da_xu_ly}/${d.tong_so} cặp • Phát hiện: ${d.so_phat_hien}
      </div>
      <div class="small text-muted">${d.started_at || ''}</div>
    </button>`;
  }).join('');

  box.querySelectorAll('button[data-id]').forEach(btn => {
    btn.onclick = () => showDot(+btn.dataset.id);
  });
}

async function showDot(id) {
  const box = document.getElementById('dotDetail');
  box.innerHTML = '<div class="card-body text-center py-5"><div class="spinner-border"></div></div>';

  try {
    const data = await api('../api/kiem-tra-trung-dot.php?id=' + id);
    const dot = data.dot;

    if (!data.ket_qua.length) {
      box.innerHTML = `<div class="card-body text-muted text-center py-5">
        Không có cặp nào vượt ngưỡng hoặc đợt chưa xong.
      </div>`;
      return;
    }

    box.innerHTML = `
      <div class="card-header bg-white fw-semibold d-flex justify-content-between">
        <span>Đợt #${dot.id} — ${dot.da_xu_ly}/${dot.tong_so} cặp — Phát hiện: ${dot.so_phat_hien}</span>
        <span class="badge bg-${dot.trang_thai === 'HOAN_TAT' ? 'success' : 'warning'}">${dot.trang_thai}</span>
      </div>
      <div class="table-responsive" style="max-height:600px;">
        <table class="table table-sm table-hover align-middle mb-0">
          <thead class="table-light sticky-top">
            <tr>
              <th>#</th><th>%</th><th>Sáng kiến A</th><th>Sáng kiến B</th><th>Đánh giá</th>
            </tr>
          </thead>
          <tbody>
            ${data.ket_qua.map((r, i) => {
              const c = r.classification;
              return `<tr>
                <td>${i+1}</td>
                <td class="fw-bold" style="color:${c.color};">${r.ty_le_tai_lieu}%</td>
                <td><span class="text-muted small">[${r.ma_a}]</span> ${escapeHtml(r.ten_a)}</td>
                <td><span class="text-muted small">[${r.ma_b}]</span> ${escapeHtml(r.ten_b)}</td>
                <td><span class="score-badge" style="background:${c.bg}; color:${c.color};">${c.emoji} ${c.label}</span></td>
              </tr>`;
            }).join('')}
          </tbody>
        </table>
      </div>`;
  } catch (e) {
    box.innerHTML = `<div class="card-body text-danger">Lỗi: ${escapeHtml(e.message)}</div>`;
  }
}