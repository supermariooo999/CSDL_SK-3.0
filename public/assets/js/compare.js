const SECTION_LABELS = {
  ten: 'Tên sáng kiến',
  linh_vuc: 'Lĩnh vực áp dụng',
  boi_canh: 'Khái quát đặc điểm, tình hình trước khi có sáng kiến',
  noi_dung: 'Nội dung sáng kiến',
  hieu_qua: 'Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp',
};

let compareResultsCache = {};
let batchCompareData = null;

let duplicateResultModal = null;
let compareDetailModal = null;


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

  /*
   * Khởi tạo modal.
   */
  const resultModalEl =
    document.getElementById('duplicateResultModal');

  if (resultModalEl) {
    duplicateResultModal =
      bootstrap.Modal.getOrCreateInstance(
        resultModalEl
      );
  }

  const detailModalEl =
    document.getElementById('compareDetailModal');

  if (detailModalEl) {
    compareDetailModal =
      bootstrap.Modal.getOrCreateInstance(
        detailModalEl
      );
  }
});


// =====================================================
// CHECKBOX
// =====================================================

function initSelectionEvents() {

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


  document.addEventListener('change', e => {

    if (!e.target.classList.contains('idea-check-item')) {
      return;
    }

    updateRowSelected(e.target);
    updateSelectedCount();

  });


  const btnClear =
    document.getElementById('btnClearSelection');

  if (btnClear) {
    btnClear.addEventListener(
      'click',
      resetSelection
    );
  }


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
// SO SÁNH
// =====================================================

async function onCompareSelected() {

  const ids = getSelectedIds();

  /*
   * Cho phép chọn 1 sáng kiến.
   *
   * Sáng kiến đó sẽ được so với
   * toàn bộ sáng kiến khác trong DB.
   */
  if (ids.length < 1) {

    showAlert(
      'Vui lòng chọn ít nhất 1 sáng kiến để kiểm tra trùng.',
      'warning'
    );

    return;
  }


  const btn =
    document.getElementById(
      'btnCompareSelected'
    );


  if (btn) {

    btn.disabled = true;

    btn.dataset.oldText =
      btn.innerHTML;

    btn.innerHTML = `
      <span
        class="spinner-border
               spinner-border-sm
               me-1"
      ></span>
      Đang kiểm tra...
    `;
  }


  try {

    /*
     * Hiển thị modal ngay từ đầu.
     *
     * Người dùng thấy hệ thống đang xử lý.
     */
    openDuplicateResultModal(true);


    showAlert(
      `Đang kiểm tra ${ids.length} sáng kiến với các sáng kiến khác...`,
      'info'
    );


    const data =
      await api(
        'api/kiem-tra-trung.php',
        {
          method: 'POST',
          body: {
            sang_kien_ids: ids
          }
        }
      );


    console.log(
      'Kết quả kiểm tra:',
      data
    );


    /*
     * Lưu dữ liệu toàn bộ batch.
     */
    batchCompareData = data;


    /*
     * Xóa cache cũ.
     */
    compareResultsCache = {};


    /*
     * Render vào modal.
     */
    renderBatchResult(data);


    showAlert(
      'Đã hoàn tất kiểm tra trùng sáng kiến.',
      'success'
    );


  } catch (error) {

    console.error(
      'onCompareSelected:',
      error
    );


    renderDuplicateError(
      error.message ||
      'Không xác định'
    );


    showAlert(
      `Lỗi kiểm tra trùng: ${
        error.message || 'Không xác định'
      }`,
      'danger'
    );


  } finally {

    if (btn) {

      btn.disabled = false;

      btn.innerHTML =
        btn.dataset.oldText ||
        '<i class="bi bi-search"></i> Kiểm tra trùng';

    }
  }
}


// =====================================================
// ALERT
// =====================================================

function showAlert(msg, type) {

  const alertBox =
    document.getElementById(
      'alertBox'
    );

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
// MỞ MODAL KẾT QUẢ
// =====================================================

function openDuplicateResultModal(
  loading = false
) {

  const modalEl =
    document.getElementById(
      'duplicateResultModal'
    );

  if (!modalEl) {
    console.error(
      'Không tìm thấy #duplicateResultModal'
    );

    return;
  }


  const body =
    document.getElementById(
      'duplicateResultBody'
    );


  if (loading && body) {

    body.innerHTML = `
      <div class="duplicate-loading">

        <div
          class="spinner-border text-primary"
        ></div>

        <div class="mt-3 fw-semibold">
          Đang phân tích sáng kiến...
        </div>

        <div class="small text-muted mt-1">
          Hệ thống đang lọc tên trước,
          sau đó mới phân tích NLP các trường hợp
          có khả năng tương đồng.
        </div>

      </div>
    `;
  }


  duplicateResultModal =
    bootstrap.Modal.getOrCreateInstance(
      modalEl
    );

  duplicateResultModal.show();
}


// =====================================================
// RENDER KẾT QUẢ BATCH
// =====================================================

function renderBatchResult(data) {

  const body =
    document.getElementById(
      'duplicateResultBody'
    );

  if (!body) {
    return;
  }


  const results =
    data?.results || [];


  /*
   * Không có kết quả.
   */
  if (!results.length) {

    renderDuplicateEmpty();

    return;
  }


  /*
   * Cache.
   */
  compareResultsCache = {};


  /*
   * Thống kê.
   */
  let totalMatches = 0;
  let highMatches = 0;


  results.forEach(item => {

    const list =
      item?.ket_qua || [];


    totalMatches +=
      list.length;


    highMatches +=
      list.filter(r =>
        Number(r?.overall || 0) >= 70
      ).length;


    /*
     * Lưu từng cặp.
     */
    const source =
      item?.sang_kien || {};


    for (const r of list) {

      const idA =
        Number(source.id || 0);

      const idB =
        Number(r?.sang_kien?.id || 0);


      if (idA <= 0 || idB <= 0) {
        continue;
      }


      compareResultsCache[
        `${idA}_${idB}`
      ] = {

        a: source,

        b:
          r.sang_kien || {},

        overall:
          Number(r.overall || 0),

        classification:
          r.classification ||
          classifyByScore(
            Number(r.overall || 0)
          ),

        sections:
          r.sections || {},

        name_score:
          Number(r.name_score || 0),

        // ✅ Thêm 2 field mới
        check_reason:
          r.check_reason || '',

        quick_score:
          r.quick_score !== undefined
            ? Number(r.quick_score)
            : null

      };
    }

  });


  /*
   * Update summary.
   */

  const selectedCount =
    document.getElementById(
      'duplicateSelectedCount'
    );

  const comparedCount =
    document.getElementById(
      'duplicateComparedCount'
    );

  const highCount =
    document.getElementById(
      'duplicateHighCount'
    );

  const subtitle =
    document.getElementById(
      'duplicateResultSubtitle'
    );


  if (selectedCount) {
    selectedCount.textContent =
      results.length;
  }


  if (comparedCount) {
    comparedCount.textContent =
      totalMatches;
  }


  if (highCount) {
    highCount.textContent =
      highMatches;
  }


  if (subtitle) {

    /*
     * ✅ Subtitle mới — phản ánh 3 tầng lọc
     */
    const skipStats =
      data?.skip_stats || {};

    const nameDiff =
      Number(skipStats.name_diff || 0);

    const contentDiff =
      Number(skipStats.content_diff || 0);

    subtitle.textContent =
      `Đã kiểm tra ${results.length} sáng kiến — ` +
      `${totalMatches} trường hợp vượt qua bộ lọc ` +
      `(bỏ qua ${nameDiff} do tên khác, ` +
      `${contentDiff} do nội dung khác)`;
  }


  /*
   * Render từng sáng kiến.
   */
  const html = [];


  results.forEach((item, index) => {

    const sk =
      item?.sang_kien || {};

    const list =
      item?.ket_qua || [];


    html.push(`
      <div class="duplicate-source-card">

        <!-- SOURCE HEADER -->

        <div class="duplicate-source-header">

          <div class="duplicate-source-label">

            <i class="bi bi-lightbulb-fill"></i>

            Sáng kiến ${index + 1}

          </div>


          <h5 class="duplicate-source-title">

            ${escapeHtml(
              sk.ten ||
              'Không có tên sáng kiến'
            )}

          </h5>


          <div class="duplicate-source-meta">

            ${
              sk.ma
                ? `
                  <span class="duplicate-meta-badge">
                    <i class="bi bi-hash"></i>
                    ${escapeHtml(sk.ma)}
                  </span>
                `
                : ''
            }


            ${
              sk.nam_id
                ? `
                  <span class="duplicate-meta-badge">
                    <i class="bi bi-calendar3"></i>
                    Năm: ${escapeHtml(sk.nam ?? sk.nam_id)}
                  </span>
                `
                : ''
            }


            <span class="duplicate-meta-badge">

              <i class="bi bi-search"></i>

              ${list.length}
              kết quả

            </span>

          </div>

        </div>
    `);


    /*
     * Không có kết quả.
     */
    if (!list.length) {

      html.push(`
        <div class="duplicate-empty">

          <div class="duplicate-empty-icon">
            <i class="bi bi-check-lg"></i>
          </div>

          <div class="duplicate-empty-title">
            Không phát hiện khả năng trùng
          </div>

          <div class="duplicate-empty-text">

            Không có sáng kiến nào vượt qua
            bộ lọc tên + tác giả + nội dung
            để cần phân tích NLP.

          </div>

        </div>
      `);

    } else {

      /*
       * Có kết quả.
       */
      html.push(`
        <div class="duplicate-result-list">
      `);


      list.forEach((r, resultIndex) => {

        const other =
          r?.sang_kien || {};


        const score =
          Number(r?.overall || 0);


        const c =
          r?.classification ||
          classifyByScore(score);


        const idA =
          Number(sk.id || 0);


        const idB =
          Number(other.id || 0);


        /*
         * ✅ Render badge lý do check
         */
        const checkReason =
          r?.check_reason || '';

        const quickScore =
          r?.quick_score !== undefined
            && r?.quick_score !== null
            ? Number(r.quick_score)
            : null;


        const reasonBadgeHtml =
          checkReason
            ? `
              <span class="check-reason-badge">
                <i class="bi bi-info-circle"></i>
                ${escapeHtml(checkReason)}
                ${
                  quickScore !== null
                    ? ` · Quick: ${quickScore.toFixed(1)}%`
                    : ''
                }
              </span>
            `
            : '';


        html.push(`
          <div class="duplicate-result-item">

            <!-- SCORE -->

            <div class="duplicate-score">

              <div
                class="duplicate-score-number"
                style="
                  color:${escapeHtml(c.color)}
                "
              >
                ${score.toFixed(1)}%
              </div>

              <div class="duplicate-score-label">
                Tương đồng
              </div>

            </div>


            <!-- CONTENT -->

            <div>

              <div class="duplicate-result-title">

                ${escapeHtml(
                  other.ten ||
                  'Không có tên'
                )}

              </div>


              <div class="duplicate-result-meta">

                ${
                  other.ma
                    ? `
                      <span>
                        <i class="bi bi-hash"></i>
                        ${escapeHtml(other.ma)}
                      </span>
                    `
                    : ''
                }


                ${
                  other.nam_id
                    ? `
                      <span>
                        <i class="bi bi-calendar3"></i>
                        Năm:
                        ${escapeHtml(other.nam ?? other.nam_id)}
                      </span>
                    `
                    : ''
                }


                ${
                  r.name_score !== undefined
                    ? `
                      <span>
                        <i class="bi bi-fonts"></i>
                        Tên:
                        ${Number(
                          r.name_score
                        ).toFixed(1)}%
                      </span>
                    `
                    : ''
                }

                ${reasonBadgeHtml}

              </div>


              <div class="duplicate-progress">

                <div
                  class="duplicate-progress-bar"
                  style="
                    width:${Math.min(
                      100,
                      Math.max(0, score)
                    )}%;
                    background:${escapeHtml(
                      c.color
                    )};
                  "
                ></div>

              </div>

            </div>


            <!-- ACTION -->

            <div class="text-end">

              <div
                class="duplicate-level mb-2"
                style="
                  color:${escapeHtml(c.color)};
                  background:${escapeHtml(c.bg)};
                "
              >

                ${c.emoji || ''}

                ${escapeHtml(
                  c.label || ''
                )}

              </div>


              <button
                type="button"
                class="btn btn-sm btn-outline-primary btn-duplicate-detail"
                onclick="
                  viewCompareDetail(
                    ${idA},
                    ${idB}
                  )
                "
              >

                <i
                  class="bi bi-layout-split me-1"
                ></i>

                Đối chiếu

              </button>

            </div>

          </div>
        `);

      });


      html.push(`
        </div>
      `);
    }


    html.push(`
      </div>
    `);

  });


  body.innerHTML =
    html.join('');
}

// =====================================================
// KHÔNG CÓ KẾT QUẢ
// =====================================================

function renderDuplicateEmpty() {

  const body =
    document.getElementById(
      'duplicateResultBody'
    );

  if (!body) {
    return;
  }


  const selectedCount =
    document.getElementById(
      'duplicateSelectedCount'
    );

  const comparedCount =
    document.getElementById(
      'duplicateComparedCount'
    );

  const highCount =
    document.getElementById(
      'duplicateHighCount'
    );

  const subtitle =
    document.getElementById(
      'duplicateResultSubtitle'
    );


  if (selectedCount) {
    selectedCount.textContent =
      batchCompareData?.selected_count || 0;
  }

  if (comparedCount) {
    comparedCount.textContent = '0';
  }

  if (highCount) {
    highCount.textContent = '0';
  }

  if (subtitle) {
    subtitle.textContent =
      'Không có trường hợp nào vượt qua bước lọc tên';
  }


  body.innerHTML = `
    <div class="duplicate-empty">

      <div class="duplicate-empty-icon">

        <i class="bi bi-shield-check"></i>

      </div>


      <div class="duplicate-empty-title">

        Không phát hiện khả năng trùng

      </div>


      <div class="duplicate-empty-text">

        Các sáng kiến đã chọn không có tên đủ
        tương đồng với các sáng kiến khác trong
        cơ sở dữ liệu để cần phân tích NLP sâu.

      </div>

    </div>
  `;
}


// =====================================================
// LỖI
// =====================================================

function renderDuplicateError(message) {

  const body =
    document.getElementById(
      'duplicateResultBody'
    );

  if (!body) {
    return;
  }


  body.innerHTML = `
    <div class="duplicate-empty">

      <div
        class="duplicate-empty-icon"
        style="
          background:#fee2e2;
          color:#dc2626;
        "
      >
        <i class="bi bi-exclamation-triangle"></i>
      </div>


      <div class="duplicate-empty-title">
        Không thể hoàn tất kiểm tra
      </div>


      <div class="duplicate-empty-text">
        ${escapeHtml(message)}
      </div>

    </div>
  `;
}


// =====================================================
// XEM CHI TIẾT 1 CẶP
// =====================================================

function viewCompareDetail(idA, idB) {

  idA = Number(idA);
  idB = Number(idB);

  const key = `${idA}_${idB}`;

  const cached =
    compareResultsCache[key];

  console.log('🔎 viewCompareDetail:', {
    idA,
    idB,
    key,
    cached,
    cache: compareResultsCache
  });

  if (!cached) {

    console.error(
      '❌ Không tìm thấy dữ liệu so sánh:',
      key
    );

    return;
  }


  /*
   * Sáng kiến nguồn
   */
  const source =
    cached.a || {};


  /*
   * Sáng kiến đối chiếu
   */
  const target =
    cached.b || {};


  /*
   * Kết quả tổng.
   */
  const overall =
    Number(cached.overall || 0);


  /*
   * Phân loại.
   */
  const classification =
    cached.classification ||
    classifyByScore(overall);


  /*
   * Các section.
   */
  const sections =
    cached.sections || {};


  /*
   * Modal.
   */
  const modalEl =
    document.getElementById(
      'compareDetailModal'
    );


  const modalBody =
    document.getElementById(
      'compareModalBody'
    );


  const modalSubtitle =
    document.getElementById(
      'compareModalSubtitle'
    );


  if (!modalEl || !modalBody) {

    console.error(
      '❌ Không tìm thấy compareDetailModal'
    );

    return;
  }


  /*
   * Subtitle.
   */
  if (modalSubtitle) {

    modalSubtitle.innerHTML = `
      <span>
        <strong>${escapeHtml(
          source.ma || `#${source.id || idA}`
        )}</strong>
      </span>

      <i class="bi bi-arrow-right mx-2"></i>

      <span>
        <strong>${escapeHtml(
          target.ma || `#${target.id || idB}`
        )}</strong>
      </span>
    `;
  }


  /*
   * Render header.
   */
  const html = [];


  html.push(`

    <div class="compare-detail-header">

      <div class="compare-detail-score">

        <div
          class="compare-detail-score-number"
          style="color:${escapeHtml(
            classification.color || '#dc2626'
          )}"
        >
          ${overall.toFixed(2)}%
        </div>

        <div class="compare-detail-score-label">
          Mức độ tương đồng
        </div>

      </div>


      <div class="compare-detail-info">

        <div class="compare-detail-item">

          <div class="compare-detail-label">
            Sáng kiến đang kiểm tra
          </div>

          <div class="compare-detail-title">
            ${escapeHtml(
              source.ten ||
              'Không có tên sáng kiến'
            )}
          </div>

        </div>


        <div class="compare-detail-item">

          <div class="compare-detail-label">
            Sáng kiến đối chiếu
          </div>

          <div class="compare-detail-title">
            ${escapeHtml(
              target.ten ||
              'Không có tên sáng kiến'
            )}
          </div>

        </div>

      </div>


      <div
        class="compare-detail-level"
        style="
          color:${escapeHtml(
            classification.color || '#dc2626'
          )};
          background:${escapeHtml(
            classification.bg || '#fee2e2'
          )};
        "
      >
        ${classification.emoji || ''}
        ${escapeHtml(
          classification.label || ''
        )}
      </div>

    </div>

  `);


  /*
   * Các section cần hiển thị.
   */
  const sectionLabels = {

    ten:
      'Tên sáng kiến',

    linh_vuc:
      'Lĩnh vực',

    boi_canh:
      'Bối cảnh / Đặc điểm',

    noi_dung:
      'Nội dung / Giải pháp',

    hieu_qua:
      'Hiệu quả / Phạm vi áp dụng'

  };


  Object.entries(sectionLabels)
    .forEach(([key, label]) => {

      const section =
        sections[key];


      if (!section) {
        return;
      }


      const score =
        Number(section.score || 0);


      const pairs =
        Array.isArray(section.pairs)
          ? section.pairs
          : [];


      /*
       * Không có dữ liệu chi tiết.
       */
      if (!pairs.length) {

        html.push(`

          <div class="compare-detail-section mb-3">

            <div class="compare-section-header">

              <div>
                <i class="bi bi-file-text me-2"></i>
                ${escapeHtml(label)}
              </div>

              <div class="compare-section-score">
                ${score.toFixed(2)}%
              </div>

            </div>

            <div class="p-3 text-muted">
              Không có đoạn văn để đối chiếu.
            </div>

          </div>

        `);

        return;
      }


      /*
       * Section có dữ liệu.
       */
      html.push(`

        <div class="compare-detail-section mb-3">

          <div class="compare-section-header">

            <div class="fw-semibold">

              <i class="bi bi-layout-split me-2"></i>

              ${escapeHtml(label)}

            </div>

            <div
              class="compare-section-score"
              style="
                color:${escapeHtml(
                  score >= 85
                    ? '#dc2626'
                    : score >= 70
                      ? '#ea580c'
                      : '#2563eb'
                )}"
            >
              ${score.toFixed(2)}%
            </div>

          </div>


          <div class="compare-section-body">

      `);


      pairs.forEach((pair, index) => {

        html.push(
          renderHighlightPair(
            pair,
            index
          )
        );

      });


      html.push(`

          </div>

        </div>

      `);

    });


  modalBody.innerHTML =
    html.join('');


  /*
   * Mở Bootstrap modal.
   */
  const modal =
    bootstrap.Modal.getOrCreateInstance(
      modalEl
    );

  modal.show();
}

// =====================================================
// CLASSIFY
// =====================================================

function classifyByScore(score) {

  score = Number(score || 0);


  if (score >= 85) {

    return {
      level: 'RAT_CAO',
      label: 'Trùng / gần như trùng',
      color: '#dc2626',
      emoji: '🔴',
      bg: '#fee2e2'
    };

  }


  if (score >= 70) {

    return {
      level: 'CAO',
      label: 'Khả năng trùng cao',
      color: '#f97316',
      emoji: '🟠',
      bg: '#ffedd5'
    };

  }


  if (score >= 50) {

    return {
      level: 'TRUNG_BINH',
      label: 'Tương đồng một phần',
      color: '#eab308',
      emoji: '🟡',
      bg: '#fef9c3'
    };

  }


  return {

    level: 'THAP',

    label: 'Khác biệt',

    color: '#16a34a',

    emoji: '🟢',

    bg: '#dcfce7'

  };
}


// =====================================================
// ESCAPE HTML
// =====================================================

function escapeHtml(value) {

  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}


// =====================================================
// HIGHLIGHT COMMON
// =====================================================

function highlightCommon(text, otherText) {

  /*
   * Escape trước để không cho HTML
   * từ dữ liệu đi thẳng vào DOM.
   */

  const safeText =
    escapeHtml(text);

  /*
   * Hiện tại giữ nguyên nội dung.
   *
   * Nếu bạn đã có hàm highlightCommon()
   * ở file khác thì có thể bỏ hàm này.
   */

  return safeText;
}

function renderHighlightPair(pair, index) {
    const textA = String(pair?.a || '');
    const textB = String(pair?.b || '');
    const score = Number(pair?.score || 0);

    const highlighted = highlightSimilarText(textA, textB);

    return `
        <div class="compare-pair">

            <div class="compare-pair-head">
                <span>
                    <i class="bi bi-hash"></i>
                    Đoạn ${index + 1}
                </span>

                <span class="compare-pair-score">
                    ${score.toFixed(2)}%
                </span>
            </div>

            <div class="compare-pair-grid">

                <div class="compare-text-box">
                    <div class="compare-text-label">
                        <i class="bi bi-file-earmark-text"></i>
                        Sáng kiến đang kiểm tra
                    </div>

                    <div class="compare-text">
                        ${highlighted.a}
                    </div>
                </div>

                <div class="compare-text-box">
                    <div class="compare-text-label">
                        <i class="bi bi-files"></i>
                        Sáng kiến đối chiếu
                    </div>

                    <div class="compare-text">
                        ${highlighted.b}
                    </div>
                </div>

            </div>
        </div>
    `;
}

function highlightSimilarText(textA, textB) {
    const a = normalizeForHighlight(textA);
    const b = normalizeForHighlight(textB);

    if (!a || !b) {
        return {
            a: escapeHtml(textA),
            b: escapeHtml(textB)
        };
    }

    // Nếu gần như giống hoàn toàn
    if (a === b) {
        return {
            a: highlightWholeText(textA),
            b: highlightWholeText(textB)
        };
    }

    const wordsA = a.split(/\s+/).filter(Boolean);
    const wordsB = b.split(/\s+/).filter(Boolean);

    const common = new Set(
        wordsA.filter(word => wordsB.includes(word))
    );

    if (common.size === 0) {
        return {
            a: escapeHtml(textA),
            b: escapeHtml(textB)
        };
    }

    return {
        a: highlightWords(textA, common),
        b: highlightWords(textB, common)
    };
}

function normalizeForHighlight(text) {
    return String(text || '')
        .toLowerCase()
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .replace(/đ/g, 'd')
        .replace(/[^\p{L}\p{N}\s]/gu, ' ')
        .replace(/\s+/g, ' ')
        .trim();
}

function highlightWords(text, commonWords) {
    const escaped = escapeHtml(text);

    if (!commonWords || commonWords.size === 0) {
        return escaped;
    }

    const pattern = Array.from(commonWords)
        .sort((a, b) => b.length - a.length)
        .map(word => escapeRegExp(word))
        .join('|');

    if (!pattern) {
        return escaped;
    }

    /*
     * Không thể tìm trực tiếp từ normalized vào text tiếng Việt
     * vì khác dấu.
     *
     * Vì vậy dùng từng token gốc để xác định từ tương ứng.
     */
    return text
        .split(/(\s+)/)
        .map(part => {
            const normalized = normalizeForHighlight(part);

            if (commonWords.has(normalized)) {
                return `<mark class="similar-highlight">${escapeHtml(part)}</mark>`;
            }

            return escapeHtml(part);
        })
        .join('');
}

function highlightWholeText(text) {
    return `<mark class="similar-highlight">${escapeHtml(text)}</mark>`;
}

function escapeRegExp(value) {
    return String(value).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function escapeHtml(value) {
    return String(value ?? '')
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}