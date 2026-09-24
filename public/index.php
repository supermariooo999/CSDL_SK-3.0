<?php require_once __DIR__ . '/../includes/helpers.php'; ?>

<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta name="theme-color" content="#6366f1">

        <title>QLSK</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap" rel="stylesheet">

        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css">
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css">

        <link href="assets/css/app.css" rel="stylesheet">
        <link href="assets/css/add.css" rel="stylesheet">
        <link href="assets/css/modal.css" rel="stylesheet">

        <link rel="stylesheet"
            href="https://cdn.datatables.net/2.1.8/css/dataTables.bootstrap5.min.css">
    </head>

    <body>


    <!-- =====================================================
        PAGE HEADER — STICKY
    ====================================================== -->

    <div class="page-header-sticky">
        <div class="container-xxl px-3 px-lg-4">
            <div class="page-header-inner">

                <div class="page-header-text">
                    <h1 class="page-title">
                        <span class="page-title-icon">
                            <i class="bi bi-grid-1x2-fill"></i>
                        </span>
                        Quản lý sáng kiến
                    </h1>
                    <div class="page-description">
                        Danh sách và phân tích trùng lặp sáng kiến
                    </div>
                </div>

                <button type="button"
                        class="btn btn-primary btn-add-initiative"
                        onclick="openAddInitiativeModal()">
                    <span class="btn-add-icon">
                        <i class="bi bi-plus-lg"></i>
                    </span>
                    Thêm sáng kiến
                </button>

            </div>
        </div>
    </div>


    <div class="container-xxl pb-5 px-3 px-lg-4">


        <!-- =====================================================
            PAGE HEADER
        ====================================================== -->

        <!-- <div class="d-flex justify-content-between align-items-center mb-4 mt-4 flex-wrap gap-3">
            <div>
                <h1 class="page-title">
                    <i class="bi bi-grid-1x2-fill text-primary me-2"></i>
                    Quản lý sáng kiến
                </h1>
                <div class="page-description">
                    Danh sách và phân tích trùng lặp sáng kiến
                </div>
            </div>

            <button type="button"
                    class="btn btn-primary px-4"
                    onclick="openAddInitiativeModal()">
                <i class="bi bi-plus-lg me-1"></i>
                Thêm sáng kiến
            </button>
        </div> -->


        <!-- =====================================================
            FILTER
        ====================================================== -->

        <div class="filter-card mt-4">

            <div class="row g-3">

                <!-- Năm -->

                <div class="col-md-3">

                    <label class="section-label">
                        <i class="bi bi-calendar3"></i>
                        Năm
                    </label>

                    <select id="filterNam" class="form-select">
                    </select>

                </div>


                <!-- Lĩnh vực -->

                <div class="col-md-3">

                    <label class="section-label">
                        <i class="bi bi-grid"></i>
                        Lĩnh vực
                    </label>

                    <select id="filterLinhVuc" class="form-select">

                        <option value="0">
                            -- Tất cả lĩnh vực --
                        </option>

                    </select>

                </div>


                <!-- Search -->

                <div class="col-md-6">

                    <label class="section-label">
                        <i class="bi bi-search"></i>
                        Tìm kiếm sáng kiến
                    </label>

                    <div class="input-group">

                        <input
                            id="searchQ"
                            class="form-control"
                            placeholder="Tìm theo tên hoặc mã sáng kiến..."
                        >

                        <button
                            id="btnSearch"
                            class="btn btn-outline-secondary"
                            type="button"
                            title="Tìm kiếm"
                        >
                            <i class="bi bi-search"></i>
                        </button>

                    </div>

                </div>

            </div>

        </div>


        <!-- =====================================================
            IDEA LIST
        ====================================================== -->

        <div class="list-card">


            <!-- LIST HEADER -->

            <div class="list-header">

                <div>

                    <h2 class="list-title">

                        <i class="bi bi-list-check text-primary me-2"></i>

                        Danh sách sáng kiến

                    </h2>

                    <div class="list-subtitle">
                        Tích chọn các sáng kiến cần kiểm tra trùng lặp
                    </div>

                </div>


                <div class="selection-info">

                    <span class="selected-count">

                        <i class="bi bi-check2-square"></i>

                        Đã chọn:
                        <strong id="selectedCount">0</strong>

                        sáng kiến

                    </span>

                    <button
                        type="button"
                        class="btn-clear"
                        id="btnClearSelection"
                    >
                        <i class="bi bi-x-circle me-1"></i>
                        Bỏ chọn
                    </button>

                </div>

            </div>


            <!-- =================================================
                TABLE
            ================================================== -->

            <div class="table-responsive">
                <table id="ideaTable"
                    class="table idea-table align-middle"
                    style="width:100%">
                    <thead>
                        <tr>
                            <th style="width:50px" class="text-center">
                                <input type="checkbox" id="checkAllIdeas" class="idea-check">
                            </th>
                            <th style="width:130px">Mã sáng kiến</th>
                            <th>Tên sáng kiến</th>
                            <th style="width:180px">Lĩnh vực</th>
                            <th style="width:100px">Năm</th>
                            <th style="width:130px">Trạng thái</th>
                            <th style="width:110px" class="text-center">Thao tác</th>
                        </tr>
                    </thead>

                    <tbody id="ideaTableBody"></tbody>
                </table>
            </div>


            <!-- =================================================
                ACTION BAR
            ================================================== -->

            <div class="action-bar">

                <div class="action-description">

                    <i class="bi bi-info-circle me-1"></i>

                    Có thể chọn từ 2 sáng kiến trở lên để hệ thống
                    phân tích mức độ tương đồng.

                </div>


                <button type="button"
                        id="btnCompareSelected"
                        class="btn btn-primary btn-check-selected">
                    <i class="bi bi-search me-2"></i>
                    Kiểm tra sáng kiến đã chọn
                </button>

            </div>

        </div>


        <!-- =====================================================
            ALERT
        ====================================================== -->

        <div id="alertBox" class="mt-3"></div>


        <!-- =====================================================
            RESULT
        ====================================================== -->

        <div id="resultBox" class="mt-4"></div>


    </div>

    <!-- =========================================================
        MODAL KẾT QUẢ KIỂM TRA TRÙNG
    ========================================================= -->

    <div
        class="modal fade"
        id="duplicateResultModal"
        tabindex="-1"
        aria-hidden="true"
    >
        <div class="modal-dialog modal-xl modal-dialog-scrollable modal-dialog-centered">

            <div class="modal-content duplicate-modal">

                <!-- HEADER -->

                <div class="modal-header duplicate-modal-header">

                    <div>

                        <div class="duplicate-modal-kicker">
                            <i class="bi bi-shield-check me-1"></i>
                            PHÂN TÍCH TRÙNG SÁNG KIẾN
                        </div>

                        <h4 class="modal-title mb-1">
                            Kết quả kiểm tra
                        </h4>

                        <div
                            id="duplicateResultSubtitle"
                            class="small text-muted"
                        >
                            Đang chuẩn bị kết quả...
                        </div>

                    </div>

                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Đóng"
                    ></button>

                </div>


                <!-- SUMMARY -->

                <div class="duplicate-summary">

                    <div class="duplicate-summary-item">

                        <div class="summary-icon bg-primary-subtle text-primary">
                            <i class="bi bi-check2-square"></i>
                        </div>

                        <div>
                            <div class="summary-label">
                                Đã chọn
                            </div>

                            <strong id="duplicateSelectedCount">
                                0
                            </strong>

                            <span>sáng kiến</span>
                        </div>

                    </div>


                    <div class="duplicate-summary-item">

                        <div class="summary-icon bg-warning-subtle text-warning-emphasis">
                            <i class="bi bi-search"></i>
                        </div>

                        <div>
                            <div class="summary-label">
                                Đã phân tích
                            </div>

                            <strong id="duplicateComparedCount">
                                0
                            </strong>

                            <span>trường hợp</span>
                        </div>

                    </div>


                    <div class="duplicate-summary-item">

                        <div class="summary-icon bg-danger-subtle text-danger">
                            <i class="bi bi-exclamation-triangle"></i>
                        </div>

                        <div>
                            <div class="summary-label">
                                Có khả năng trùng
                            </div>

                            <strong id="duplicateHighCount">
                                0
                            </strong>

                            <span>trường hợp</span>
                        </div>

                    </div>

                </div>


                <!-- BODY -->

                <div
                    class="modal-body duplicate-modal-body"
                    id="duplicateResultBody"
                >

                    <div class="duplicate-loading">

                        <div class="spinner-border text-primary"></div>

                        <div class="mt-3">
                            Đang phân tích sáng kiến...
                        </div>

                        <div class="small text-muted mt-1">
                            Vui lòng chờ trong giây lát
                        </div>

                    </div>

                </div>


                <!-- FOOTER -->

                <div class="modal-footer duplicate-modal-footer">

                    <div class="small text-muted me-auto">
                        <i class="bi bi-info-circle me-1"></i>
                        Hệ thống chỉ đưa vào kết quả những sáng kiến
                        có khả năng tương đồng sau bước lọc tên.
                    </div>

                    <button
                        type="button"
                        class="btn btn-outline-secondary"
                        data-bs-dismiss="modal"
                    >
                        Đóng
                    </button>

                </div>

            </div>

        </div>
    </div>

    <div class="modal fade" id="compareDetailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">

        <div class="modal-header">
            <div>
            <h5 class="modal-title">
                <i class="bi bi-layout-split me-2"></i>
                Đối chiếu chi tiết
            </h5>
            <div id="compareModalSubtitle" class="small text-muted mt-1"></div>
            </div>

            <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Đóng">
            </button>
        </div>

        <div class="modal-body" id="compareModalBody">
        </div>

        </div>
    </div>
    </div>

    <div class="modal fade" id="initiativeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-scrollable">
            <div class="modal-content">

                <div class="modal-header">
                    <div>
                        <h5 class="modal-title mb-1" id="initiativeModalTitle">
                            Thêm sáng kiến
                        </h5>
                        <div class="text-muted small">
                            Nhập thông tin theo từng bước
                        </div>
                    </div>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <!-- STEPPER -->
                    <div class="stepper mb-4">

                        <div class="step-item active" data-step="1">
                            <div class="step-number">1</div>
                            <div class="step-label">
                                <strong>Thông tin chung</strong>
                                <small>Thông tin sáng kiến</small>
                            </div>
                        </div>

                        <div class="step-line"></div>

                        <div class="step-item" data-step="2">
                            <div class="step-number">2</div>
                            <div class="step-label">
                                <strong>Tác giả</strong>
                                <small>Chọn người tham gia</small>
                            </div>
                        </div>

                        <div class="step-line"></div>

                        <div class="step-item" data-step="3">
                            <div class="step-number">3</div>
                            <div class="step-label">
                                <strong>Tài liệu</strong>
                            </div>
                        </div>

                    </div>

                    <form id="initiativeForm"
                        enctype="multipart/form-data">

                        <input type="hidden"
                            name="action"
                            value="save">

                        <input type="hidden"
                            name="id"
                            id="initiativeId"
                            value="">

                        <!-- ========================= -->
                        <!-- BƯỚC 1 -->
                        <!-- ========================= -->
                        <div class="form-step active" data-step="1">

                            <div class="row g-3">

                                <div class="col-md-4">
                                    <label class="form-label">
                                        Mã sáng kiến <span class="text-danger">*</span>
                                    </label>

                                    <input type="text"
                                        class="form-control"
                                        name="ma"
                                        id="ma"
                                        required
                                        maxlength="50">
                                </div>

                                <div class="col-md-8">
                                    <label class="form-label">
                                        Tên sáng kiến <span class="text-danger">*</span>
                                    </label>

                                    <input type="text"
                                        class="form-control"
                                        name="ten"
                                        id="ten"
                                        required
                                        maxlength="500">
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">
                                        Năm <span class="text-danger">*</span>
                                    </label>

                                    <select class="form-select"
                                            name="nam_id"
                                            id="nam_id"
                                            required>
                                        <option value="">-- Chọn năm --</option>
                                    </select>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">
                                        Lĩnh vực <span class="text-danger">*</span>
                                    </label>

                                    <select class="form-select"
                                            name="linh_vuc_id"
                                            id="linh_vuc_id"
                                            required>
                                        <option value="">-- Chọn lĩnh vực --</option>
                                    </select>
                                </div>

                                <div class="col-md-4" id="ngayNopField">
                                    <label class="form-label">
                                        Ngày nộp
                                    </label>

                                    <input type="date"
                                        class="form-control"
                                        name="ngay_nop"
                                        id="ngay_nop"
                                        placeholder="dd/mm/yyyy"
                                        autocomplete="off">
                                </div>

                                <div class="col-md-4" id="trangThaiField">
                                    <label class="form-label">
                                        Trạng thái
                                    </label>

                                    <select class="form-select"
                                            name="trang_thai"
                                            id="trang_thai">

                                        <option value="DA_NOP">
                                            Đã nộp
                                        </option>

                                        <option value="DANG_CHAM">
                                            Đang chấm
                                        </option>

                                        <option value="DA_CHAM">
                                            Đã chấm
                                        </option>

                                    </select>
                                </div>

                                <div
                                    class="mb-3"
                                    id="otherCQTField"
                                    style=""
                                >
                                    <label
                                        for="ten_co_quan_thue"
                                        class="form-label fw-semibold"
                                    >
                                        Tên Cơ quan Thuế
                                    </label>

                                    <input
                                        type="text"
                                        class="form-control"
                                        name="ten_co_quan_thue"
                                        id="ten_co_quan_thue"
                                        maxlength="255"
                                        placeholder="Nhập tên Cơ quan Thuế"
                                    >
                                </div>

                            </div>

                        </div>


                        <!-- ========================= -->
                        <!-- BƯỚC 2 -->
                        <!-- ========================= -->
                        <div class="form-step" data-step="2" id="authorStep">

                            <div class="alert alert-light border">
                                <i class="bi bi-info-circle me-1"></i>

                                Người được chọn đầu tiên sẽ là
                                <strong>Tác giả</strong>.
                                Những người tiếp theo là
                                <strong>Đồng tác giả</strong>.
                            </div>

                            <div class="row g-3 mb-3">

                                <div class="col-md-8">
                                    <label class="form-label">
                                        Tìm nhân viên
                                    </label>

                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-search"></i>
                                        </span>

                                        <input type="text"
                                            class="form-control"
                                            id="authorSearch"
                                            placeholder="Nhập họ tên hoặc mã nhân viên...">
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">
                                        Phòng ban
                                    </label>

                                    <select class="form-select"
                                            id="filterAuthorDepartment">

                                        <option value="">
                                            -- Tất cả phòng ban --
                                        </option>

                                    </select>
                                </div>

                            </div>

                            <div class="border rounded"
                                style="max-height: 360px; overflow-y:auto;">

                                <div id="employeeList"
                                    class="list-group list-group-flush">

                                    <div class="text-center text-muted py-4">
                                        Đang tải nhân viên...
                                    </div>

                                </div>

                            </div>

                            <div class="mt-4">

                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <strong>
                                        Người đã chọn
                                    </strong>

                                    <span class="badge bg-primary"
                                        id="authorCount">
                                        0
                                    </span>
                                </div>

                                <div id="selectedAuthors"
                                    class="border rounded p-2 bg-light">

                                    <div class="text-muted text-center py-3">
                                        Chưa chọn tác giả
                                    </div>

                                </div>

                            </div>

                        </div>


                        <!-- ========================= -->
                        <!-- BƯỚC 3 -->
                        <!-- ========================= -->
                        <div class="form-step" data-step="3">

                            <!-- MẪU 01 -->
                            <div class="file-box mb-3">

                                <div class="file-box-title">
                                    <div>
                                        <i class="bi bi-file-earmark-word text-primary"></i>
                                        <strong>Mẫu số 01/SK</strong>
                                    </div>

                                    <span class="badge bg-secondary">
                                        01 file
                                    </span>
                                </div>

                                <div class="mt-3">
                                    <input type="file"
                                        class="form-control file-mau"
                                        name="file_mau_01"
                                        id="file_mau_01"
                                        accept=".docx">

                                    <div class="form-text">
                                        Chỉ nhận file DOCX. Tối đa 20MB.
                                    </div>

                                    <div id="existingFileMau01"
                                        class="mt-2"></div>
                                </div>

                            </div>


                            <!-- MẪU 05 -->
                            <div class="file-box mb-3">

                                <div class="file-box-title">
                                    <div>
                                        <i class="bi bi-file-earmark-word text-primary"></i>
                                        <strong>Mẫu số 05/SK</strong>
                                    </div>

                                    <span class="badge bg-secondary">
                                        01 file
                                    </span>
                                </div>

                                <div class="mt-3">

                                    <input type="file"
                                        class="form-control file-mau"
                                        name="file_mau_05"
                                        id="file_mau_05"
                                        accept=".docx">

                                    <div class="form-text">
                                        Chỉ nhận file DOCX. Tối đa 20MB.
                                    </div>

                                    <div id="existingFileMau05"
                                        class="mt-2"></div>

                                </div>

                            </div>


                            <!-- MẪU 06 -->
                            <div class="file-box mb-3">

                                <div class="file-box-title">
                                    <div>
                                        <i class="bi bi-file-earmark-word text-primary"></i>
                                        <strong>Mẫu số 06/SK</strong>
                                    </div>

                                    <span class="badge bg-secondary">
                                        01 file
                                    </span>
                                </div>

                                <div class="mt-3">

                                    <input type="file"
                                        class="form-control file-mau"
                                        name="file_mau_06"
                                        id="file_mau_06"
                                        accept=".docx">

                                    <div class="form-text">
                                        Chỉ nhận file DOCX. Tối đa 20MB.
                                    </div>

                                    <div id="existingFileMau06"
                                        class="mt-2"></div>

                                </div>

                            </div>


                            <!-- MINH CHỨNG -->
                            <div class="file-box">

                                <div class="file-box-title">

                                    <div>
                                        <i class="bi bi-paperclip text-success"></i>
                                        <strong>Tài liệu minh chứng</strong>
                                    </div>

                                    <span class="badge bg-success">
                                        Chọn nhiều
                                    </span>

                                </div>

                                <div class="mt-3">

                                    <input type="file"
                                        class="form-control file-mau"
                                        name="files_minh_chung[]"
                                        id="files_minh_chung"
                                        multiple
                                        accept=".docx,.pdf,.jpg,.jpeg,.png,.xls,.xlsx">

                                    <div class="form-text">
                                        Có thể chọn nhiều file.
                                        DOC, DOCX, PDF, JPG, PNG, XLS, XLSX.
                                        Tối đa 20MB/file.
                                    </div>

                                    <div id="minhChungPreview"
                                        class="mt-3"></div>

                                    <div id="existingFilesMinhChung"
                                        class="mt-3"></div>

                                </div>

                            </div>

                        </div>

                    </form>

                </div>


                <div class="modal-footer">

                    <button type="button"
                            class="btn btn-light"
                            data-bs-dismiss="modal">
                        Hủy
                    </button>

                    <button type="button"
                            class="btn btn-outline-secondary d-none"
                            id="btnPrevStep">
                        <i class="bi bi-arrow-left"></i>
                        Quay lại
                    </button>

                    <button type="button"
                            class="btn btn-primary"
                            id="btnNextStep">
                        Tiếp tục
                        <i class="bi bi-arrow-right"></i>
                    </button>

                    <button type="button"
                            class="btn btn-success d-none"
                            id="btnSaveInitiative">
                        <i class="bi bi-check-lg"></i>
                        Lưu sáng kiến
                    </button>

                </div>

            </div>
        </div>
    </div>

    <!-- =========================================================
        BOOTSTRAP
    ========================================================= -->

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.14.5/sweetalert2.all.min.js"
    ></script>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.datatables.net/2.1.8/js/dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/2.1.8/js/dataTables.bootstrap5.min.js"></script>


    <!-- =========================================================
        EXISTING JS
    ========================================================= -->
    <script src="assets/js/utils.js"></script>
    <script src="assets/js/common.js"></script>
    <script src="assets/js/load.js"></script>
    <script src="assets/js/compare.js"></script>
    <script src="assets/js/add.js"></script>
    <script src="assets/js/edit.js"></script>
    <script src="assets/js/delete.js"></script>


    <!-- =========================================================
        MULTI SELECT UI
    ========================================================= -->

    <script>



    </script>

    </body>
</html>