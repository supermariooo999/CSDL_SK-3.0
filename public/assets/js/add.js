// assets/js/add.js

/* =====================================================
   STATE
===================================================== */

let employees = [];
let selectedAuthors = [];
let currentStep = 1;
let initiativeModal = null;


/* =====================================================
   INIT
===================================================== */

document.addEventListener("DOMContentLoaded", () => {

    const modalEl = document.getElementById("initiativeModal");
    if (modalEl) {
        initiativeModal = bootstrap.Modal.getOrCreateInstance(modalEl);

        // Reset state khi modal đóng
        modalEl.addEventListener("hidden.bs.modal", () => {
            document
                .querySelectorAll("#initiativeModal .step-item")
                .forEach(el => el.classList.remove("active", "done"));

            document
                .querySelectorAll("#initiativeModal .form-step")
                .forEach(el => el.classList.remove("active"));

            currentStep = 1;
        });
    }

    bindStepEvents();
    bindFilePreview();
    setStep(1);

    // Delegation cho checkbox tác giả
    document
        .getElementById("employeeList")
        ?.addEventListener("change", e => {
            const cb = e.target.closest(".author-checkbox");
            if (!cb) return;
            handleAuthorChange(cb);
        });

    // Delegation cho nút xoá tác giả
    document
        .getElementById("selectedAuthors")
        ?.addEventListener("click", e => {
            const btn = e.target.closest("[data-remove-author]");
            if (!btn) return;

            const id = String(btn.dataset.removeAuthor);
            selectedAuthors = selectedAuthors.filter(
                aid => String(aid) !== id
            );

            renderEmployees();
            renderSelectedAuthors();
        });

    // Filter tác giả
    document
        .getElementById("authorSearch")
        ?.addEventListener("input", renderEmployees);

    document
        .getElementById("filterAuthorDepartment")
        ?.addEventListener("change", renderEmployees);
});


/* =====================================================
   OPEN MODAL — THÊM MỚI
===================================================== */

async function openAddInitiativeModal() {
    const form = document.getElementById("initiativeForm");
    const modalEl = document.getElementById("initiativeModal");

    if (!form || !modalEl) {
        console.error("Không tìm thấy form hoặc modal");
        return;
    }

    // Load nhân viên lần đầu
    if (!employees.length) {
        await loadEmployees();
    }

    // Reset toàn bộ state + UI
    resetForm();

    const title = document.getElementById("initiativeModalTitle");
    if (title) title.textContent = "Thêm sáng kiến";

    // Nạp danh mục
    fillCatalogSelects();

    // Mở modal
    bootstrap.Modal.getOrCreateInstance(modalEl).show();
}

window.openAddInitiativeModal = openAddInitiativeModal;


/* =====================================================
   NẠP DANH MỤC NĂM / LĨNH VỰC
===================================================== */

function fillCatalogSelects() {

    const selNam = document.getElementById("nam_id");
    if (selNam) {
        const current = selNam.value;
        selNam.innerHTML =
            '<option value="">-- Chọn năm --</option>' +
            (window.danhMuc?.nam || [])
                .map(n => `<option value="${n.id}">${n.nam}</option>`)
                .join("");
        if (current) selNam.value = current;
    }

    const selLv = document.getElementById("linh_vuc_id");
    if (selLv) {
        const current = selLv.value;
        selLv.innerHTML =
            '<option value="">-- Chọn lĩnh vực --</option>' +
            (window.danhMuc?.linh_vuc || [])
                .map(l => `
                    <option value="${l.id}">
                        ${escapeHtml(l.ten)}
                    </option>
                `)
                .join("");
        if (current) selLv.value = current;
    }
}


/* =====================================================
   STEP
===================================================== */

function bindStepEvents() {

    document
        .getElementById("btnNextStep")
        ?.addEventListener("click", nextStep);

    document
        .getElementById("btnPrevStep")
        ?.addEventListener("click", previousStep);

    document
        .getElementById("btnSaveInitiative")
        ?.addEventListener("click", saveForm);

    document
        .getElementById("btnSkipStep")
        ?.addEventListener("click", skipCurrentStep);
}


function setStep(step) {

    currentStep = step;

    document
        .querySelectorAll("#initiativeModal .form-step")
        .forEach(el => {
            el.classList.toggle(
                "active",
                Number(el.dataset.step) === step
            );
        });

    document
        .querySelectorAll("#initiativeModal .step-item")
        .forEach(el => {

            const itemStep = Number(el.dataset.step);

            // Xoá sạch trước để tránh class "done" tồn đọng
            el.classList.remove("active", "done");

            if (itemStep === step) {
                el.classList.add("active");
            } else if (itemStep < step) {
                el.classList.add("done");
            }
        });

    const btnPrev = document.getElementById("btnPrevStep");
    const btnNext = document.getElementById("btnNextStep");
    const btnSave = document.getElementById("btnSaveInitiative");
    const btnSkip = document.getElementById("btnSkipStep");

    btnPrev?.classList.toggle("d-none", step === 1);
    btnNext?.classList.toggle("d-none", step === 3);
    btnSave?.classList.toggle("d-none", step !== 3);
}


function nextStep() {

    if (!validateStep(currentStep)) return;

    if (currentStep < 3) {
        setStep(currentStep + 1);
    }
}


function previousStep() {
    if (currentStep > 1) {
        setStep(currentStep - 1);
    }
}

/* =====================================================
   VALIDATE
===================================================== */

function validateStep(step) {

    if (step === 1) {

        const requiredFields = ["ma", "ten", "nam_id", "linh_vuc_id"];

        for (const id of requiredFields) {

            const element = document.getElementById(id);

            if (!element?.value.trim()) {
                element?.focus();
                toast("Vui lòng nhập đầy đủ thông tin bắt buộc.", "warning");
                return false;
            }
        }

        return true;
    }

    // Bước 2: không bắt buộc tác giả (nút Bỏ qua đã có)
    return true;
}

/* =====================================================
   RESET FORM
===================================================== */

function resetForm() {

    const form = document.getElementById("initiativeForm");
    form?.reset();

    document.getElementById("initiativeId").value = "";
    selectedAuthors = [];

    // Clear stepper trước khi setStep
    document
        .querySelectorAll("#initiativeModal .step-item")
        .forEach(el => el.classList.remove("active", "done"));

    document
        .querySelectorAll("#initiativeModal .form-step")
        .forEach(el => el.classList.remove("active"));

    setStep(1);

    const trangThai = document.getElementById("trang_thai");
    if (trangThai) trangThai.value = "DA_NOP";

    // Reset tác giả
    renderSelectedAuthors();
    renderEmployees();

    // Clear file previews
    ["existingFileMau01", "existingFileMau05", "existingFileMau06",
     "existingFilesMinhChung", "minhChungPreview"]
        .forEach(id => {
            const el = document.getElementById(id);
            if (el) el.innerHTML = "";
        });
}


function setDefaultDateTime() {

    const input = document.getElementById("ngay_nop");
    if (!input) return;

    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, "0");
    const day = String(now.getDate()).padStart(2, "0");

    input.value = `${year}-${month}-${day}`;
}


/* =====================================================
   EDIT
===================================================== */

function setSelectedAuthors(ids) {

    selectedAuthors = (ids || [])
        .map(x => {
            // Hỗ trợ cả [{id: 15}] và [15]
            if (typeof x === "object" && x !== null) {
                return String(x.id ?? x.nhan_vien_id ?? "");
            }
            return String(x);
        })
        .filter(Boolean);

    renderEmployees();
    renderSelectedAuthors();
}

window.setSelectedAuthors = setSelectedAuthors;


function setValue(id, value) {

    const element = document.getElementById(id);

    if (element) {
        element.value = value ?? "";
    }
}


/* =====================================================
   FILES
===================================================== */

function bindFilePreview() {

    document
        .getElementById("files_minh_chung")
        ?.addEventListener("change", previewMinhChung);
}


function previewMinhChung(event) {

    const files = Array.from(event.target.files || []);
    const container = document.getElementById("minhChungPreview");

    if (!container) return;

    if (!files.length) {
        container.innerHTML = "";
        return;
    }

    container.innerHTML = `
        <div class="list-group">
            ${files.map(file => `
                <div class="list-group-item d-flex justify-content-between">
                    <span>
                        <i class="bi bi-paperclip me-2"></i>
                        ${escapeHtml(file.name)}
                    </span>
                    <span class="text-muted small">
                        ${formatBytes(file.size)}
                    </span>
                </div>
            `).join("")}
        </div>
    `;
}

/* =====================================================
   SAVE
===================================================== */

async function saveForm() {

    if (!validateStep(1)) {
        setStep(1);
        return;
    }

    const form = document.getElementById("initiativeForm");
    const formData = new FormData(form);

    // Xoá author_ids cũ rồi thêm theo đúng thứ tự
    formData.delete("author_ids[]");

    selectedAuthors.forEach(id => {
        formData.append("author_ids[]", id);
    });

    // Ngày nộp: chuẩn hoá về Y-m-d
    const raw = document.getElementById("ngay_nop")?.value.trim() || "";
    if (raw) {
        formData.set("ngay_nop", raw.slice(0, 10));
    }

    // Tên CQT
    const t = document.getElementById("ten_co_quan_thue")?.value.trim() || "";
    formData.set("ten_co_quan_thue", t);

    const button = document.getElementById("btnSaveInitiative");
    const oldHtml = button.innerHTML;

    button.disabled = true;
    button.innerHTML = `
        <span class="spinner-border spinner-border-sm me-1"></span>
        Đang lưu...
    `;

    try {

        const result = await api(
            "../api/sang-kien-save.php",
            { method: "POST", body: formData }
        );

        await Swal.fire({
            icon: "success",
            title: "Đã lưu",
            text: result.message || "Lưu sáng kiến thành công.",
            timer: 1800,
            showConfirmButton: false,
        });

        bootstrap.Modal
            .getOrCreateInstance(document.getElementById("initiativeModal"))
            .hide();

        // Refresh danh sách
        if (typeof loadSangKien === "function") {
            loadSangKien();
        }

    } catch (error) {

        Swal.fire({
            icon: "error",
            title: "Không thể lưu",
            text: error.message || "Lỗi không xác định",
        });

    } finally {

        button.disabled = false;
        button.innerHTML = oldHtml;
    }
}


/* =====================================================
   NHÂN VIÊN
===================================================== */

async function loadEmployees() {

    try {
        const list = await api("../api/nhan-vien-list.php");

        employees = Array.isArray(list) ? list : [];

        renderAuthorDepartments();
        renderEmployees();

    } catch (error) {

        console.error("loadEmployees:", error);
        employees = [];
        renderEmployees();
        toast("Không thể tải danh sách nhân viên.", "error");
    }
}


function renderAuthorDepartments() {

    const sel = document.getElementById("filterAuthorDepartment");
    if (!sel) return;

    const map = new Map();

    employees.forEach(e => {
        const id = e.id_phong_ban;
        const ten = e.ten_phong || `Phòng #${id}`;
        if (id && !map.has(String(id))) {
            map.set(String(id), ten);
        }
    });

    const current = sel.value;

    sel.innerHTML =
        '<option value="">-- Tất cả phòng ban --</option>' +
        [...map.entries()]
            .map(([id, ten]) => `
                <option value="${escapeHtml(id)}">
                    ${escapeHtml(ten)}
                </option>
            `)
            .join("");

    if (current && map.has(current)) {
        sel.value = current;
    }
}


function renderEmployees() {

    const container = document.getElementById("employeeList");
    if (!container) return;

    const keyword =
        (document.getElementById("authorSearch")?.value || "")
            .trim()
            .toLowerCase();

    const department =
        document.getElementById("filterAuthorDepartment")?.value || "";

    const filtered = employees.filter(employee => {

        const hoTen = String(employee.ho_ten || "").toLowerCase();
        const maNV = String(employee.ma_nhan_vien || "").toLowerCase();

        const matchKeyword =
            !keyword || hoTen.includes(keyword) || maNV.includes(keyword);

        const matchDepartment =
            !department ||
            String(employee.id_phong_ban) === String(department);

        return matchKeyword && matchDepartment;
    });

    if (!filtered.length) {
        container.innerHTML = `
            <div class="text-center text-muted py-4">
                Không tìm thấy nhân viên.
            </div>
        `;
        return;
    }

    const frag = document.createDocumentFragment();

    filtered.forEach(employee => {

        const id = String(employee.id);
        const selected = selectedAuthors.some(aid => aid === id);

        const label = document.createElement("label");
        label.className =
            "list-group-item employee-item" +
            (selected ? " selected" : "");

        label.innerHTML = `
            <div class="d-flex align-items-center">
                <input
                    class="form-check-input me-3 author-checkbox"
                    type="checkbox"
                    value="${escapeHtml(id)}"
                    ${selected ? "checked" : ""}
                >
                <div class="flex-grow-1">
                    <div class="fw-semibold">
                        ${escapeHtml(employee.ho_ten || "")}
                    </div>
                    <div class="small text-muted">
                        ${escapeHtml(employee.ma_nhan_vien || "")}
                        ${
                            employee.ten_phong
                                ? " · " + escapeHtml(employee.ten_phong)
                                : ""
                        }
                    </div>
                </div>
            </div>
        `;

        frag.appendChild(label);
    });

    container.innerHTML = "";
    container.appendChild(frag);
}


function handleAuthorChange(checkbox) {

    const id = String(checkbox.value);

    if (checkbox.checked) {
        if (!selectedAuthors.some(aid => aid === id)) {
            selectedAuthors.push(id);
        }
    } else {
        selectedAuthors = selectedAuthors.filter(aid => aid !== id);
    }

    const label = checkbox.closest(".employee-item");
    label?.classList.toggle("selected", checkbox.checked);

    renderSelectedAuthors();
}


function renderSelectedAuthors() {

    const container = document.getElementById("selectedAuthors");
    const counter = document.getElementById("authorCount");

    if (counter) counter.textContent = selectedAuthors.length;

    if (!container) return;

    if (!selectedAuthors.length) {
        container.innerHTML = `
            <div class="text-muted text-center py-3">
                Chưa chọn tác giả
            </div>
        `;
        return;
    }

    container.innerHTML = selectedAuthors.map((id, index) => {

        const emp = employees.find(e => String(e.id) === String(id));

        const hoTen = emp?.ho_ten || `#${id}`;
        const maNV  = emp?.ma_nhan_vien || "";
        const phong = emp?.ten_phong || "";

        const vaiTro = index === 0 ? "Tác giả" : "Đồng tác giả";

        return `
            <div class="author-row">
                <div class="author-order">${index + 1}</div>

                <div class="author-info">
                    <div class="author-name">
                        ${escapeHtml(hoTen)}
                        <span class="badge bg-primary ms-2">${vaiTro}</span>
                    </div>
                    <div class="author-department">
                        ${escapeHtml(maNV)}
                        ${phong ? " · " + escapeHtml(phong) : ""}
                    </div>
                </div>

                <button
                    type="button"
                    class="btn btn-sm btn-outline-danger"
                    data-remove-author="${escapeHtml(id)}"
                    title="Xoá"
                >
                    <i class="bi bi-x"></i>
                </button>
            </div>
        `;
    }).join("");
}