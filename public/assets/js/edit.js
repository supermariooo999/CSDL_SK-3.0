// assets/js/edit.js
// =====================================================
// CHỨC NĂNG SỬA SÁNG KIẾN
// Phụ thuộc: add.js (đã load trước)
// =====================================================

/**
 * Mở modal chỉnh sửa sáng kiến.
 * @param {number|string} id - ID sáng kiến
 */
async function editInitiativeById(id) {
    id = Number(id);

    if (!id || id <= 0) {
        toast('ID sáng kiến không hợp lệ', 'error');
        return;
    }

    // Hiển thị loading
    if (window.Swal) {
        Swal.fire({
            title: 'Đang tải dữ liệu...',
            allowOutsideClick: false,
            allowEscapeKey: false,
            didOpen: () => Swal.showLoading(),
        });
    }

    try {
        // 1. Đảm bảo employees đã load (cần cho bước tác giả)
        if (!employees.length) {
            await loadEmployees();
        }

        // 2. Gọi API detail
        const row = await api(
            `api/sang-kien-detail.php?id=${encodeURIComponent(id)}`
        );

        if (!row || !row.id) {
            throw new Error('Không tìm thấy sáng kiến');
        }

        // 3. Lấy modal element
        const modalEl = document.getElementById('initiativeModal');
        if (!modalEl) {
            throw new Error('Không tìm thấy #initiativeModal');
        }

        // 4. Reset form về trạng thái sạch
        resetForm();

        // 5. Nạp danh mục TRƯỚC fillForm (để select có options)
        fillCatalogSelects();

        // 6. Fill dữ liệu
        fillFormForEdit(row);

        // 7. Đổi tiêu đề
        const title = document.getElementById('initiativeModalTitle');
        if (title) title.textContent = 'Chỉnh sửa sáng kiến';

        // 8. Đảm bảo ở bước 1
        setStep(1);

        // 9. Đóng loading + mở modal
        if (window.Swal) Swal.close();

        bootstrap.Modal
            .getOrCreateInstance(modalEl)
            .show();

    } catch (error) {
        if (window.Swal) Swal.close();

        console.error('editInitiativeById:', error);

        Swal.fire({
            icon: 'error',
            title: 'Không thể tải dữ liệu',
            text: error.message || 'Lỗi không xác định',
        });
    }
}


/**
 * Fill dữ liệu sáng kiến vào form (dùng riêng cho edit).
 * Khác fillForm() của add.js ở chỗ: chỉ gọi khi đã có đủ authors + files.
 */
function fillFormForEdit(row) {
    if (!row) return;

    // ---------- Hidden ID ----------
    const idInput = document.getElementById('initiativeId');
    if (idInput) idInput.value = row.id || '';

    // ---------- Text fields ----------
    setValue('ma', row.ma);
    setValue('ten', row.ten);
    setValue('noi_dung', row.noi_dung);
    setValue('muc_tieu', row.muc_tieu);
    setValue('ket_qua_du_kien', row.ket_qua_du_kien);
    setValue('ghi_chu', row.ghi_chu);
    setValue('ten_co_quan_thue', row.ten_co_quan_thue);
    setValue('trang_thai', row.trang_thai || 'DA_NOP');

    // ---------- Select ----------
    setValue('nam_id',       row.nam_id       ? String(row.nam_id)       : '');
    setValue('linh_vuc_id',  row.linh_vuc_id  ? String(row.linh_vuc_id)  : '');

    // ---------- Ngày nộp ----------
    if (row.ngay_nop) {
        const ngayNop = document.getElementById('ngay_nop');
        if (ngayNop) {
            ngayNop.value = String(row.ngay_nop).slice(0, 10);
        }
    }

    // ---------- Tác giả ----------
    const authorIds = extractAuthorIds(row);
    setSelectedAuthors(authorIds);

    // ---------- File đính kèm ----------
    renderExistingFilesForEdit(row.files || []);
}


/**
 * Trích xuất ID tác giả từ response API.
 * Hỗ trợ nhiều format: [12, 15] hoặc [{id:12}, {id:15}]
 */
function extractAuthorIds(row) {
    const raw =
        row.authors ||
        row.tac_gia_ids ||
        row.author_ids ||
        [];

    if (!Array.isArray(raw)) return [];

    return raw
        .map(item => {
            if (typeof item === 'object' && item !== null) {
                return String(item.id ?? item.nhan_vien_id ?? '');
            }
            return String(item);
        })
        .filter(Boolean);
}


/**
 * Render danh sách file đã đính kèm — dạng list item gọn.
 */
function renderExistingFilesForEdit(files) {
    const groups = {
        MAU_01:     'existingFileMau01',
        MAU_05:     'existingFileMau05',
        MAU_06:     'existingFileMau06',
        MINH_CHUNG: 'existingFilesMinhChung',
    };

    // Clear tất cả container
    Object.values(groups).forEach(id => {
        const el = document.getElementById(id);
        if (el) el.innerHTML = '';
    });

    if (!files.length) return;

    files.forEach(file => {
        const containerId = groups[file.loai_file];
        if (!containerId) return;

        const container = document.getElementById(containerId);
        if (!container) return;

        container.insertAdjacentHTML('beforeend', `
            <div class="existing-file-item">
                <i class="bi bi-file-earmark-text"></i>

                <span class="existing-file-name"
                      title="${escapeHtml(file.ten_file || '')}">
                    ${escapeHtml(file.ten_file || 'Không rõ tên')}
                </span>

                <a
                    href="api/sang-kien-download.php?id=${encodeURIComponent(file.id)}"
                    target="_blank"
                    class="btn btn-sm btn-outline-primary"
                    title="Tải xuống"
                >
                    <i class="bi bi-download"></i>
                </a>
            </div>
        `);
    });
}


// =====================================================
// EXPORT
// =====================================================

window.editItem = editInitiativeById;
window.editInitiative = editInitiativeById;
window.editInitiativeById = editInitiativeById;