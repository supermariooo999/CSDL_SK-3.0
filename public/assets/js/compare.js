const SECTION_LABELS = {
  ten:       'Tên sáng kiến',
  boi_canh:  'Bối cảnh / Đặc điểm',
  muc_tieu:  'Mục tiêu / Sự cần thiết',
  noi_dung:  'Nội dung / Giải pháp',
  tinh_moi:  'Tính mới',
  hieu_qua:  'Hiệu quả',
  pham_vi:   'Phạm vi áp dụng',
};


// =====================================================
// INIT
// =====================================================

document.addEventListener('DOMContentLoaded', async () => {

  await loadDanhMuc();
  await loadSangKien();

  document.getElementById('btnSearch').onclick =
    loadSangKien;

  document.getElementById('searchQ')
    .addEventListener('keydown', e => {

      if (e.key === 'Enter') {
        loadSangKien();
      }

    });

  document.getElementById('filterNam').onchange =
    loadSangKien;

  document.getElementById('filterLinhVuc').onchange =
    loadSangKien;

  initSelectionEvents();
});


// =====================================================
// CHECKBOX
// =====================================================

function initSelectionEvents() {

  // Chọn tất cả
  const checkAll =
    document.getElementById('checkAllIdeas');

  if (checkAll) {

    checkAll.addEventListener('change', () => {

      document
        .querySelectorAll('.idea-check-item')
        .forEach(cb => {

          cb.checked = checkAll.checked;

          updateRowSelected(cb);

        });

      updateSelectedCount();

    });
  }


  // Chọn từng sáng kiến
  document.addEventListener('change', e => {

    if (!e.target.classList.contains('idea-check-item')) {
      return;
    }

    updateRowSelected(e.target);
    updateSelectedCount();

  });


  // Bỏ chọn
  const btnClear =
    document.getElementById('btnClearSelection');

  if (btnClear) {

    btnClear.addEventListener('click', resetSelection);

  }


  // So sánh
  const btnCompare =
    document.getElementById('btnCompareSelected');

  if (btnCompare) {

    btnCompare.addEventListener(
      'click',
      onCompareSelected
    );

  }
}


// =====================================================
// HIGHLIGHT ROW
// =====================================================

function updateRowSelected(checkbox) {

  const row = checkbox.closest('tr');

  if (!row) {
    return;
  }

  row.classList.toggle(
    'selected',
    checkbox.checked
  );
}


// =====================================================
// ĐẾM ĐÃ CHỌN
// =====================================================

function updateSelectedCount() {

  const selected =
    document.querySelectorAll(
      '.idea-check-item:checked'
    );

  const count = selected.length;

  const countEl =
    document.getElementById('selectedCount');

  if (countEl) {
    countEl.textContent = count;
  }


  // Cập nhật checkbox chọn tất cả
  const all =
    document.querySelectorAll(
      '.idea-check-item'
    );

  const checkAll =
    document.getElementById('checkAllIdeas');

  if (!checkAll) {
    return;
  }

  if (!all.length) {

    checkAll.checked = false;
    checkAll.indeterminate = false;

    return;
  }

  checkAll.checked =
    count === all.length;

  checkAll.indeterminate =
    count > 0 &&
    count < all.length;
}


// =====================================================
// LẤY ID ĐÃ CHỌN
// =====================================================

function getSelectedIds() {

  return [
    ...document.querySelectorAll(
      '.idea-check-item:checked'
    )
  ]
    .map(cb => Number(cb.value))
    .filter(id => id > 0);
}


// =====================================================
// RESET
// =====================================================

function resetSelection() {

  document
    .querySelectorAll('.idea-check-item')
    .forEach(cb => {

      cb.checked = false;

      updateRowSelected(cb);

    });


  const checkAll =
    document.getElementById('checkAllIdeas');

  if (checkAll) {

    checkAll.checked = false;
    checkAll.indeterminate = false;

  }


  const count =
    document.getElementById('selectedCount');

  if (count) {
    count.textContent = '0';
  }
}


// =====================================================
// SO SÁNH
// =====================================================

async function onCompareSelected() {

  const ids = getSelectedIds();

  if (ids.length < 2) {

    showAlert(
      'Vui lòng chọn ít nhất 2 sáng kiến để kiểm tra trùng.',
      'warning'
    );

    return;
  }

  console.log('Sáng kiến được chọn:', ids);

  /*
   * Ví dụ:
   *
   * [27, 24, 23]
   *
   * sẽ tạo các cặp:
   *
   * 27 - 24
   * 27 - 23
   * 24 - 23
   *
   * API batch sẽ xử lý phần này.
   */

  showAlert(
    `Đã chọn ${ids.length} sáng kiến.`,
    'info'
  );
}


// =====================================================
// ALERT
// =====================================================

function showAlert(msg, type) {

  const alertBox =
    document.getElementById('alertBox');

  if (!alertBox) {
    return;
  }

  alertBox.innerHTML = `
    <div class="alert alert-${type} py-2 mb-0">
      ${escapeHtml(msg)}
    </div>
  `;
}


// =====================================================
// RENDER KẾT QUẢ
// =====================================================

function renderResult(data) {

  const cls = data.classification;

  const html = [];

  // Tổng thể
  html.push(`
    <div
      class="card border-0 shadow-sm mb-4"
      style="background:${cls.bg};"
    >

      <div
        class="card-body d-flex
               justify-content-between
               align-items-center"
      >

        <div>

          <div class="text-muted small">
            Mức độ tương đồng tổng thể
          </div>

          <div
            class="score-number"
            style="color:${cls.color};"
          >
            ${data.overall}%
          </div>

          <div class="fs-5 mt-1">
            ${cls.emoji}
            <strong>${cls.label}</strong>
          </div>

          <div class="small text-muted mt-2">

            <strong>A:</strong>
            [${escapeHtml(data.a.ma)}]
            ${escapeHtml(data.a.ten)}

            <br>

            <strong>B:</strong>
            [${escapeHtml(data.b.ma)}]
            ${escapeHtml(data.b.ten)}

          </div>

        </div>

        <div style="font-size:5rem;">
          ${cls.emoji}
        </div>

      </div>
    </div>
  `);


  // Tiêu chí
  html.push(`
    <div class="card shadow-sm mb-4">

      <div class="card-body">

        <h5 class="mb-3">
          <i class="bi bi-list-check"></i>
          Chi tiết theo tiêu chí
        </h5>

        <table
          class="table table-sm
                 criteria-table
                 align-middle"
        >

          <thead class="table-light">

            <tr>
              <th>Tiêu chí</th>
              <th style="width:35%">
                Mức giống
              </th>
              <th style="width:15%">
                Đánh giá
              </th>
            </tr>

          </thead>

          <tbody>

            ${Object.entries(data.sections)
              .map(([k, v]) => {

                const s = +v.score;
                const c = classifyByScore(s);

                return `
                  <tr>

                    <td>
                      ${SECTION_LABELS[k] || k}
                    </td>

                    <td>

                      <div
                        class="d-flex
                               align-items-center
                               gap-2"
                      >

                        <div
                          class="progress-thin
                                 flex-grow-1"
                        >
                          <div
                            style="
                              width:${s}%;
                              background:${c.color};
                            "
                          ></div>
                        </div>

                        <span
                          class="fw-semibold"
                          style="
                            color:${c.color};
                            min-width:60px;
                          "
                        >
                          ${s}%
                        </span>

                      </div>

                    </td>

                    <td>

                      <span
                        class="score-badge"
                        style="
                          background:${c.bg};
                          color:${c.color};
                        "
                      >
                        ${c.emoji} ${c.label}
                      </span>

                    </td>

                  </tr>
                `;

              })
              .join('')}

            <tr class="total">

              <td>
                Tổng thể (có trọng số)
              </td>

              <td>
                ${data.overall}%
              </td>

              <td>
                ${cls.emoji}
                ${cls.label}
              </td>

            </tr>

          </tbody>

        </table>

      </div>
    </div>
  `);


  // Chi tiết
  html.push(`
    <h5 class="mb-3">
      <i class="bi bi-brush"></i>
      Đối chiếu chi tiết
    </h5>
  `);


  for (const [k, v] of Object.entries(data.sections)) {

    const s = +v.score;
    const c = classifyByScore(s);

    html.push(`
      <div class="section-card mb-3">

        <div class="section-head">

          <span>
            ${SECTION_LABELS[k] || k}
          </span>

          <span
            class="score-badge"
            style="
              background:${c.bg};
              color:${c.color};
            "
          >
            ${c.emoji} ${s}%
          </span>

        </div>

        <div class="p-3">

          ${
            v.pairs.length

              ? v.pairs.map(p => {

                  const pc =
                    classifyByScore(p.score);

                  return `
                    <div class="pair-row">

                      <div
                        class="pair-cell"
                        style="
                          border-color:${pc.color};
                          background:${pc.bg}33;
                        "
                      >

                        <div class="label">
                          📘 A
                        </div>

                        <div>
                          ${highlightCommon(p.a, p.b)}
                        </div>

                      </div>


                      <div
                        class="pair-cell"
                        style="
                          border-color:${pc.color};
                          background:${pc.bg}33;
                        "
                      >

                        <div class="label">
                          📕 B
                        </div>

                        <div>
                          ${highlightCommon(p.b, p.a)}
                        </div>

                      </div>

                    </div>
                  `;

                }).join('')

              : `
                <div
                  class="text-muted
                         fst-italic
                         small"
                >
                  Không có cặp câu
                  tương đồng nổi bật
                </div>
              `
          }

        </div>
      </div>
    `);
  }


  document.getElementById('resultBox').innerHTML =
    html.join('');
}