<?php require_once __DIR__ . '/../includes/helpers.php'; ?>

<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">

<title>Kiểm tra trùng sáng kiến</title>

<!-- Bootstrap 5.3.3 - Cloudflare CDN -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css">

<!-- Bootstrap Icons - Cloudflare CDN -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css">

<link href="assets/css/app.css" rel="stylesheet">

<style>


</style>

</head>

<body>


<!-- =========================================================
     NAVBAR
========================================================= -->

<nav class="navbar navbar-expand-lg mb-4">

    <div class="container-fluid px-4">

        <a class="navbar-brand fw-bold" href="index.php">
            <i class="bi bi-lightbulb-fill text-warning me-1"></i>
            Quản lý Sáng kiến
        </a>

        <ul class="navbar-nav ms-auto">

            <li class="nav-item">
                <a class="nav-link active" href="index.php">
                    <i class="bi bi-table me-1"></i>
                    Danh sách sáng kiến
                </a>
            </li>

        </ul>

    </div>

</nav>


<div class="container-xxl pb-5 px-3 px-lg-4">


    <!-- =====================================================
         PAGE HEADER
    ====================================================== -->

    <div class="page-header">

        <h1 class="page-title">
            Kiểm tra trùng sáng kiến
        </h1>

        <p class="page-description">
            Chọn nhiều sáng kiến trong danh sách để hệ thống phân tích
            và phát hiện các sáng kiến có khả năng trùng lặp.
        </p>

    </div>


    <!-- =====================================================
         FILTER
    ====================================================== -->

    <div class="filter-card">

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

            <table class="table idea-table align-middle">

                <thead>

                    <tr>

                        <th style="width:50px" class="text-center">

                            <input
                                type="checkbox"
                                id="checkAllIdeas"
                                class="idea-check"
                                title="Chọn tất cả"
                            >

                        </th>

                        <th style="width:130px">
                            Mã sáng kiến
                        </th>

                        <th>
                            Tên sáng kiến
                        </th>

                        <th style="width:180px">
                            Lĩnh vực
                        </th>

                        <th style="width:100px">
                            Năm
                        </th>

                        <th style="width:130px">
                            Trạng thái
                        </th>

                    </tr>

                </thead>


                <tbody id="ideaTableBody">

                    <!--
                        JS sẽ load danh sách sáng kiến vào đây
                    -->

                    <tr>

                        <td colspan="6" class="empty-table">

                            <i class="bi bi-inbox"></i>

                            <div>
                                Đang tải danh sách sáng kiến...
                            </div>

                        </td>

                    </tr>

                </tbody>

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


            <button
                type="button"
                id="btnCompareSelected"
                class="btn btn-primary btn-check-selected"
            >

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
     BOOTSTRAP
========================================================= -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>


<!-- =========================================================
     EXISTING JS
========================================================= -->

<!-- <script src="assets/js/common.js"></script> -->
<script src="assets/js/load.js"></script>
<script src="assets/js/compare.js"></script>


<!-- =========================================================
     MULTI SELECT UI
========================================================= -->

<script>



</script>

</body>
</html>