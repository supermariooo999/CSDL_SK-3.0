
const STATUS_MAP = {
    DA_NOP:    { label: 'Đã nộp',    cls: 'status-submitted'  },
    DANG_CHAM: { label: 'Đang chấm', cls: 'status-reviewing'  },
    DA_CHAM:   { label: 'Đã chấm',   cls: 'status-reviewed'   },
};
const LOAI_MAP = {
    NOI_BO:   { label: 'Nội bộ',     cls: 'loai-noi-bo'   },
    KHAC_CQT: { label: 'Khác CQT',   cls: 'loai-khac-cqt' },
};

// =====================================================
// DATATABLES INSTANCE
// =====================================================

let ideaDataTable = null;


document.addEventListener('DOMContentLoaded', () => {

    const tableBody     = document.getElementById('ideaTableBody');
    const selectedCount = document.getElementById('selectedCount');
    const checkAll      = document.getElementById('checkAllIdeas');
    const clearButton   = document.getElementById('btnClearSelection');

    // =====================================================
    // CẬP NHẬT SỐ LƯỢNG ĐÃ CHỌN
    // =====================================================

    function updateSelectedCount() {

        if (!selectedCount) return;

        // Chỉ đếm checkbox đang visible (DataTables ẩn row khác)
        const visibleCheckboxes = document.querySelectorAll(
            '#ideaTableBody .idea-check-item'
        );

        let checkedCount = 0;

        for (const cb of visibleCheckboxes) {
            const row = cb.closest('tr');
            if (!row) continue;

            if (cb.checked) {
                checkedCount++;
                row.classList.add('selected');
            } else {
                row.classList.remove('selected');
            }
        }

        selectedCount.textContent = checkedCount;

        if (!checkAll) return;

        if (visibleCheckboxes.length === 0) {
            checkAll.checked = false;
            checkAll.indeterminate = false;
            return;
        }

        checkAll.checked = checkedCount === visibleCheckboxes.length;
        checkAll.indeterminate = checkedCount > 0 && checkedCount < visibleCheckboxes.length;
    }

    window.updateSelectedCount = updateSelectedCount;

    // =====================================================
    // CHECKBOX TỪNG DÒNG
    // =====================================================

    tableBody?.addEventListener('change', function (e) {
        if (e.target.classList.contains('idea-check-item')) {
            updateSelectedCount();
        }
    });

    // =====================================================
    // CHỌN TẤT CẢ
    // =====================================================

    checkAll?.addEventListener('change', function () {
        // Chỉ chọn các checkbox đang visible trong table hiện tại
        document.querySelectorAll('#ideaTableBody .idea-check-item')
            .forEach(cb => { cb.checked = checkAll.checked; });

        updateSelectedCount();
    });

    // =====================================================
    // BỎ CHỌN TẤT CẢ
    // =====================================================

    clearButton?.addEventListener('click', function () {
        document.querySelectorAll('.idea-check-item')
            .forEach(function (checkbox) {
                checkbox.checked = false;
            });

        if (checkAll) {
            checkAll.checked = false;
            checkAll.indeterminate = false;
        }

        updateSelectedCount();
    });

    // =====================================================
    // ACTION DELEGATION (edit / delete)
    // =====================================================

    tableBody?.addEventListener('click', function (e) {
        
        const btn = e.target.closest('button[data-action]');
        if (!btn) return;

        const tr = btn.closest('tr');
        if (!tr) return;

        const id   = Number(tr.dataset.id);
        const code = tr.querySelector('.idea-code')?.textContent?.trim() || '';

        if (!id) return;

        switch (btn.dataset.action) {

            case 'edit':
                window.editInitiative?.(id);
                break;

            case 'delete':
                window.deleteInitiative?.(id, code);
                break;
        }
    });

    initDataTable();

});

// =====================================================
// KHỞI TẠO DATATABLES
// =====================================================

function initDataTable() {

    const table = document.getElementById('ideaTable');
    if (!table || !window.jQuery) return;

    // Xoá data cũ + destroy nếu có
    if ($.fn.DataTable.isDataTable(table)) {
        $(table).DataTable().destroy();
    }

    ideaDataTable = $(table).DataTable({
        // ---------- NGÔN NGỮ ----------
        autoWidth: false,
        language: {
            search:        'Tìm nhanh:',
            lengthMenu:    'Hiển thị _MENU_ dòng',
            info:          'Trang _PAGE_ / _PAGES_ — Tổng _TOTAL_ sáng kiến',
            infoEmpty:     'Không có dữ liệu',
            infoFiltered:  '(lọc từ _MAX_ sáng kiến)',
            zeroRecords:   'Không tìm thấy sáng kiến nào',
            emptyTable:    'Chưa có sáng kiến',
            paginate: {
                first:    '«',
                previous: '‹',
                next:     '›',
                last:     '»',
            },
        },

        // ---------- LAYOUT ----------
        pageLength: 5,
        lengthMenu: [
            [5, 10, 20, 50, 100, -1],
            [5, 10, 20, 50, 100, 'Tất cả'],
        ],
        order: [[1, 'asc']],   // sort theo mã sáng kiến giảm dần
        columnDefs: [
            // Cột 0 (checkbox) + cột 6 (thao tác) không sort
            { orderable: false, targets: [0, 6] },
            // Cột 1: sort theo số cuối của mã
            {
                targets: 1, // cột Mã sáng kiến
                className: 'text-start',
                render: function (data, type) {
                    const text = $('<div>').html(data).text().trim();

                    if (type === 'sort' || type === 'type') {
                        const match = text.match(/(\d{3})$/);
                        return match ? parseInt(match[1], 10) : 0;
                    }

                    return data;
                }
            },
            // Cột 4 (năm) sort theo số
            { type: 'num', targets: [4], className: 'text-center' },
            { targets: [5], className: 'text-center' },
           
            // Chiều rộng theo %
            { width: '5%',  targets: 0 },
            { width: '10%', targets: 1 },
            { width: '35%', targets: 2 },
            { width: '15%', targets: 3 },
            { width: '10%', targets: 4 },
            { width: '15%', targets: 5 },
            { width: '10%', targets: 6 },
        ],

        // ---------- DOM ----------
        // Bỏ filter/search mặc định vì đã có filter ngoài
        // dom: 'lrtip' — chỉ giữ length, table, info, pagination
        // (bỏ 'f' = filter, 's' = search box)
        dom:
            "<'row mb-2'<'col-sm-6'l><'col-sm-6'>>" +
            "<'row'<'col-12'tr>>" +
            "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",

        // ---------- KHÔNG XÓA DOM ----------
        // Giữ nguyên HTML do mình render → event delegation vẫn chạy
        destroy: true,

        createdRow: function (row, data, dataIndex) {
            // data là mảng cell bạn add vào
            // Không có id ở đây → lấy từ checkbox bên trong
            const cb = row.querySelector('.idea-check-item');
            if (cb) {
                row.dataset.id = cb.value;
            }
        },
    });

    // =====================================================
    // RE-BIND EVENT SAU KHI DATATABLES REDRAW
    // =====================================================
    // DataTables di chuyển DOM → phải bind lại 1 số thứ

    ideaDataTable.on('draw', () => {
        // Cập nhật counter "đã chọn" sau khi page đổi
        window.updateSelectedCount?.();
    });
}


// =====================================================
// RENDER BẢNG (gọi từ load.js)
// =====================================================

window.renderIdeaTable = function (ideas) {

    if (!ideaDataTable) {
        // Fallback nếu DataTables chưa init
        console.warn('DataTable chưa init, bỏ qua render');
        return;
    }

    // Xoá sạch data cũ
    ideaDataTable.clear();

    if (!ideas || ideas.length === 0) {
        ideaDataTable.draw();
        window.updateSelectedCount?.();
        return;
    }

    // Helper pick
    const pick = (obj, keys, fallback = '') => {
        for (const k of keys) {
            if (obj[k] !== undefined && obj[k] !== null) return obj[k];
        }
        return fallback;
    };

    // Build mảng row HTML (DataTables nhận mảng array)
    const rows = ideas.map(idea => {

        const id     = pick(idea, ['id', 'ID', 'id_sang_kien']);
        const code   = pick(idea, ['ma', 'ma_sang_kien', 'code'], id);
        const name   = pick(idea, ['ten', 'ten_sang_kien', 'name']);
        const field  = pick(idea, ['linh_vuc', 'ten_linh_vuc', 'field']);
        const year   = pick(idea, ['nam', 'nam_sang_kien', 'year']);
        const statusRaw = pick(idea, ['trang_thai', 'status']);

        const statusMeta = STATUS_MAP[statusRaw] || {
            label: statusRaw || '—',
            cls: ''
        };

        const idStr     = escapeHtml(String(id));
        const codeStr   = escapeHtml(String(code));
        const nameStr   = escapeHtml(String(name));
        const fieldStr  = escapeHtml(String(field));
        const yearStr   = escapeHtml(String(year));
        const statusStr = escapeHtml(statusMeta.label);

        return [
            // [0] checkbox
            `<div class="text-center">
                <input
                    type="checkbox"
                    class="idea-check idea-check-item"
                    value="${idStr}"
                >
            </div>`,

            // [1] mã
            `<span class="idea-code">${codeStr}</span>`,

            // [2] tên
            `<div class="idea-name">${nameStr}</div>`,

            // [3] lĩnh vực
            `<span class="idea-field">${fieldStr}</span>`,

            // [4] năm
            `<span class="idea-year">${yearStr}</span>`,

            // [5] trạng thái
            `<span class="status-badge ${statusMeta.cls}">${statusStr}</span>`,

            // [6] thao tác
            `<div class="text-center d-flex gap-1 justify-content-center">
                <button
                    type="button"
                    class="btn btn-sm btn-icon btn-edit"
                    data-action="edit"
                    title="Sửa"
                ><i class="bi bi-pencil"></i></button>

                <button
                    type="button"
                    class="btn btn-sm btn-icon btn-delete"
                    data-action="delete"
                    title="Xoá"
                ><i class="bi bi-trash"></i></button>
            </div>`,

        ];
    });

    // Thêm data + redraw
    ideaDataTable.rows.add(rows).draw(false);

    // Cập nhật counter
    window.updateSelectedCount?.();
};

// =====================================================
// RESET SELECTION
// =====================================================

function resetSelection() {

    document.querySelectorAll('.idea-check-item')
        .forEach(cb => { cb.checked = false; });

    const checkAll = document.getElementById('checkAllIdeas');
    if (checkAll) {
        checkAll.checked = false;
        checkAll.indeterminate = false;
    }

    const count = document.getElementById('selectedCount');
    if (count) count.textContent = '0';
}

window.resetSelection = resetSelection;


// =====================================================
// GET SELECTED IDEAS
// =====================================================

window.getSelectedIdeas = function () {
    return Array.from(
        document.querySelectorAll('#ideaTableBody .idea-check-item:checked')
    ).map(cb => cb.value);
};


// =====================================================
// TOAST
// =====================================================

function toast(title, icon = "info") {

    Swal.fire({
        icon: icon,
        title: title,
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 2200,
        timerProgressBar: true
    });
}

window.toast = toast;

// =====================================================
// PAGE HEADER STICKY — hiệu ứng khi scroll
// =====================================================

document.addEventListener('DOMContentLoaded', () => {
    const header = document.querySelector('.page-header-sticky');
    if (!header) return;

    let ticking = false;

    const updateStuckState = () => {
        // Lấy vị trí top của navbar (navbar cao ~62px)
        const navbar = document.querySelector('.navbar');
        const navbarBottom = navbar
            ? navbar.getBoundingClientRect().bottom
            : 0;

        // Nếu header đã chạm navbar → set stuck
        const headerTop = header.getBoundingClientRect().top;
        const shouldStick = headerTop <= navbarBottom + 1;

        header.classList.toggle('is-stuck', shouldStick);
        ticking = false;
    };

    const onScroll = () => {
        if (!ticking) {
            window.requestAnimationFrame(updateStuckState);
            ticking = true;
        }
    };

    window.addEventListener('scroll', onScroll, { passive: true });
    window.addEventListener('resize', onScroll, { passive: true });

    // Chạy lần đầu
    updateStuckState();
});