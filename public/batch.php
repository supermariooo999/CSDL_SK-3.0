<?php require_once __DIR__ . '/../includes/helpers.php'; ?>
<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Kiểm tra chéo cả năm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="assets/css/app.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-white border-bottom mb-4">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="index.php">
      <i class="bi bi-lightbulb text-warning"></i> Quản lý Sáng kiến
    </a>
    <ul class="navbar-nav">
      <li class="nav-item"><a class="nav-link" href="index.php">So sánh cặp</a></li>
      <li class="nav-item"><a class="nav-link active" href="batch.php">Kiểm tra cả năm</a></li>
    </ul>
  </div>
</nav>

<div class="container-xxl pb-5">
  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <h5 class="mb-3"><i class="bi bi-collection"></i> Kiểm tra trùng chéo toàn bộ sáng kiến trong một năm</h5>
      <div class="row g-3 align-items-end">
        <div class="col-md-3">
          <label class="form-label">Năm</label>
          <select id="batchNam" class="form-select"></select>
        </div>
        <div class="col-md-3">
          <label class="form-label">Lĩnh vực (tuỳ chọn)</label>
          <select id="batchLinhVuc" class="form-select"><option value="0">-- Tất cả --</option></select>
        </div>
        <div class="col-md-3">
          <button id="btnRun" class="btn btn-warning w-100">
            <i class="bi bi-play-fill"></i> Bắt đầu kiểm tra
          </button>
        </div>
        <div class="col-md-3">
          <button id="btnReload" class="btn btn-outline-secondary w-100">
            <i class="bi bi-arrow-clockwise"></i> Nạp danh sách đợt
          </button>
        </div>
      </div>
      <div id="batchMsg" class="mt-3"></div>
    </div>
  </div>

  <div class="row g-3">
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-header bg-white fw-semibold">Các đợt đã chạy</div>
        <div class="list-group list-group-flush" id="dotList" style="max-height:600px; overflow-y:auto;">
          <div class="list-group-item text-muted small">Chưa có dữ liệu</div>
        </div>
      </div>
    </div>
    <div class="col-md-8">
      <div id="dotDetail" class="card shadow-sm">
        <div class="card-body text-muted text-center py-5">
          <i class="bi bi-arrow-left-circle fs-3"></i><br>Chọn một đợt để xem chi tiết
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/common.js"></script>
<script src="assets/js/batch.js"></script>
</body>
</html>