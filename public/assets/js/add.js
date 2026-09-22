console.log(danhMuc);

function openAddInitiativeModal() {
    const form = document.getElementById('initiativeForm');
    const modalEl = document.getElementById('initiativeModal');

    if (!form || !modalEl) {
        console.error('Không tìm thấy initiativeForm hoặc initiativeModal');
        return;
    }

    // Reset form
    form.reset();

    // Reset ID
    const idInput = document.getElementById('initiativeId');
    if (idInput) {
        idInput.value = '';
    }

    // Tiêu đề modal
    const title = document.getElementById('initiativeModalTitle');
    if (title) {
        title.textContent = 'Thêm sáng kiến';
    }

    // Reset về bước 1
    document.querySelectorAll('#initiativeModal .form-step')
        .forEach(step => step.classList.remove('active'));

    document.querySelector('#initiativeModal .form-step[data-step="1"]')
        ?.classList.add('active');

    // Reset stepper
    document.querySelectorAll('#initiativeModal .step-item')
        .forEach(step => step.classList.remove('active'));

    document.querySelector('#initiativeModal .step-item[data-step="1"]')
        ?.classList.add('active');

    // Nút
    document.getElementById('btnPrevStep')
        ?.classList.add('d-none');

    document.getElementById('btnNextStep')
        ?.classList.remove('d-none');

    document.getElementById('btnSaveInitiative')
        ?.classList.add('d-none');

    // Xóa danh sách tác giả đã chọn nếu có
    const selectedAuthors = document.getElementById('selectedAuthors');
    if (selectedAuthors) {
        selectedAuthors.innerHTML = `
            <div class="text-muted text-center py-3">
                Chưa chọn tác giả
            </div>
        `;
    }

    const authorCount = document.getElementById('authorCount');
    if (authorCount) {
        authorCount.textContent = '0';
    }

    // ==========================
    // Nạp danh mục vào modal
    // ==========================

    const selNam = document.getElementById('nam_id');

    if (selNam) {
        selNam.innerHTML =
            '<option value="">-- Chọn năm --</option>' +
            (window.danhMuc?.nam || [])
                .map(n => `
                    <option value="${n.id}">
                        ${n.nam}
                    </option>
                `)
                .join('');
    }

    const selLv = document.getElementById('linh_vuc_id');

    if (selLv) {
        selLv.innerHTML =
            '<option value="">-- Chọn lĩnh vực --</option>' +
            (window.danhMuc?.linh_vuc || [])
                .map(l => `
                    <option value="${l.id}">
                        ${escapeHtml(l.ten)}
                    </option>
                `)
                .join('');
    }


    // Mở modal
    bootstrap.Modal.getOrCreateInstance(modalEl).show();
}

let currentStep = 1;
let isOtherCQT = false;

document.addEventListener(
    "DOMContentLoaded",
    async () => {

        bindStepEvents();

        bindFilePreview();

        setStep(1);
    }
);

/* =====================================================
   STEP
===================================================== */

function bindStepEvents() {

    document
        .getElementById("btnNextStep")
        ?.addEventListener(
            "click",
            nextStep
        );

    document
        .getElementById("btnPrevStep")
        ?.addEventListener(
            "click",
            previousStep
        );

    document
        .getElementById("btnSaveInitiative")
        ?.addEventListener(
            "click",
            saveForm
        );
}


function setStep(step) {

    currentStep = step;

    document
        .querySelectorAll(".form-step")
        .forEach(element => {

            element.classList.toggle(
                "active",
                Number(
                    element.dataset.step
                ) === step
            );

        });


    document
        .querySelectorAll(".step-item")
        .forEach(element => {

            const itemStep =
                Number(
                    element.dataset.step
                );

            element.classList.toggle(
                "active",
                itemStep === step
            );

            element.classList.toggle(
                "done",
                itemStep < step
            );

        });


    const btnPrev =
        document.getElementById(
            "btnPrevStep"
        );

    const btnNext =
        document.getElementById(
            "btnNextStep"
        );

    const btnSave =
        document.getElementById(
            "btnSaveInitiative"
        );


    btnPrev?.classList.toggle(
        "d-none",
        step === 1
    );

    btnNext?.classList.toggle(
        "d-none",
        step === 3
    );

    btnSave?.classList.toggle(
        "d-none",
        step !== 3
    );
}


function nextStep() {

    if (!validateStep(currentStep)) {
        return;
    }


    if (isOtherCQT && currentStep === 1) {

        setStep(3);

        return;
    }


    if (currentStep < 3) {

        setStep(currentStep + 1);
    }
}


function previousStep() {

    if (isOtherCQT && currentStep === 3) {

        setStep(1);

        return;
    }


    if (currentStep > 1) {

        setStep(currentStep - 1);
    }
}


/* =====================================================
   VALIDATE
===================================================== */

function validateStep(step) {

    if (step === 1) {

        const requiredFields = [
            "ma",
            "ten",
            "nam_id",
            "linh_vuc_id"
        ];

        /*
         * Sáng kiến khác CQT
         */
        if (isOtherCQT) {
            requiredFields.push(
                "ten_co_quan_thue"
            );
        }


        for (const id of requiredFields) {

            const element =
                document.getElementById(id);

            if (!element?.value.trim()) {

                element?.focus();

                toast(
                    "Vui lòng nhập đầy đủ thông tin bắt buộc.",
                    "warning"
                );

                return false;
            }
        }

        return true;
    }


    /*
     * Sáng kiến khác CQT không cần tác giả
     */
    if (step === 2 && isOtherCQT) {
        return true;
    }


    if (step === 2) {

        if (!selectedAuthors.length) {

            toast(
                "Vui lòng chọn ít nhất một tác giả.",
                "warning"
            );

            return false;
        }

        return true;
    }


    return true;
}


/* =====================================================
   CREATE
===================================================== */

function openCreateModal() {

    isOtherCQT = false;

    resetForm();

    document.getElementById(
        "initiativeModalTitle"
    ).textContent =
        "Thêm sáng kiến";

    initiativeModal.show();
}

function openCreateOtherCQT() {

    isOtherCQT = true;

    resetForm();

    document.getElementById(
        "initiativeModalTitle"
    ).textContent =
        "Thêm sáng kiến khác CQT";

    initiativeModal.show();
}

function toggleOtherCQTFields() {

    const ngayNopField =
        document.getElementById("ngayNopField");

    const trangThaiField =
        document.getElementById("trangThaiField");

    if (isOtherCQT) {

        ngayNopField?.classList.add("d-none");

        trangThaiField?.classList.add("d-none");

    } else {

        ngayNopField?.classList.remove("d-none");

        trangThaiField?.classList.remove("d-none");
    }
}

function resetForm() {

    const form =
        document.getElementById("initiativeForm");

    form.reset();

    document.getElementById(
        "initiativeId"
    ).value = "";

    selectedAuthors = [];

    setStep(1);

    /*
     * Chỉ set ngày mặc định cho sáng kiến nội bộ
     */
    if (!isOtherCQT) {
        setDefaultDateTime();
    } else {
        const ngayNop =
            document.getElementById("ngay_nop");

        if (ngayNop) {
            ngayNop.value = "";
        }
    }

    document.getElementById(
        "trang_thai"
    ).value = "DA_NOP";

    renderEmployees();
    renderSelectedAuthors();

    document.getElementById(
        "existingFileMau01"
    ).innerHTML = "";

    document.getElementById(
        "existingFileMau05"
    ).innerHTML = "";

    document.getElementById(
        "existingFileMau06"
    ).innerHTML = "";

    document.getElementById(
        "existingFilesMinhChung"
    ).innerHTML = "";

    document.getElementById(
        "minhChungPreview"
    ).innerHTML = "";

    /*
     * Tên Cơ quan Thuế
     */
    const tenCoQuanThue =
        document.getElementById(
            "ten_co_quan_thue"
        );

    if (tenCoQuanThue) {
        tenCoQuanThue.value = "";
        tenCoQuanThue.required = isOtherCQT;
    }

    /*
     * Hiển thị / ẩn field CQT
     */
    const otherCQTField =
        document.getElementById(
            "otherCQTField"
        );

    if (otherCQTField) {
        otherCQTField.style.display =
            isOtherCQT ? "block" : "none";
    }

    /*
     * Tác giả
     */
    const authorStep =
        document.getElementById("authorStep");

    if (authorStep) {
        authorStep.style.display =
            isOtherCQT ? "none" : "";
    }

    /*
     * Ngày nộp + trạng thái
     */
    toggleOtherCQTFields();
}

function setDefaultDateTime() {

    const input =
        document.getElementById("ngay_nop");

    if (!input) return;

    const now = new Date();

    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, "0");
    const day = String(now.getDate()).padStart(2, "0");

    input.value =
        `${day}/${month}/${year}`;
}


/* =====================================================
   EDIT
===================================================== */

async function editItem(id) {

    try {

        const result =
            await api(
                "detail",
                {
                    params: { id }
                }
            );

        fillForm(result.data);

        document.getElementById(
            "initiativeModalTitle"
        ).textContent =
            "Chỉnh sửa sáng kiến";

        initiativeModal.show();

    } catch (error) {

        toast(
            error.message,
            "error"
        );
    }
}


function fillForm(row) {

    document.getElementById(
        "initiativeId"
    ).value =
        row.id || "";

    setValue("ma", row.ma || row.ma_sang_kien);
    setValue("ten", row.ten || row.ten_sang_kien);
    setValue("nam_id", row.nam_id);
    setValue("linh_vuc_id", row.linh_vuc_id);

    setValue(
        "noi_dung",
        row.noi_dung
    );

    setValue(
        "muc_tieu",
        row.muc_tieu
    );

    setValue(
        "ket_qua_du_kien",
        row.ket_qua_du_kien
    );

    setValue(
        "ghi_chu",
        row.ghi_chu
    );

    setValue(
        "trang_thai",
        row.trang_thai || "DA_NOP"
    );

    if (row.ngay_nop) {

        document.getElementById("ngay_nop").value =
            formatDateVN(row.ngay_nop);
    }


    const authorIds =
        row.authors ||
        row.tac_gia_ids ||
        [];

    setSelectedAuthors(
        authorIds
    );


    renderExistingFiles(
        row.files || []
    );

    setStep(1);
}


function setValue(id, value) {

    const element =
        document.getElementById(id);

    if (element) {
        element.value =
            value ?? "";
    }
}


/* =====================================================
   FILES
===================================================== */

function bindFilePreview() {

    document
        .getElementById("files_minh_chung")
        ?.addEventListener(
            "change",
            previewMinhChung
        );
}


function previewMinhChung(event) {

    const files =
        Array.from(
            event.target.files || []
        );

    const container =
        document.getElementById(
            "minhChungPreview"
        );

    if (!files.length) {

        container.innerHTML = "";

        return;
    }

    container.innerHTML = `
        <div class="list-group">
            ${
                files.map(file => `
                    <div class="list-group-item d-flex justify-content-between">
                        <span>
                            <i class="bi bi-paperclip me-2"></i>
                            ${escapeHtml(file.name)}
                        </span>

                        <span class="text-muted small">
                            ${formatBytes(file.size)}
                        </span>
                    </div>
                `).join("")
            }
        </div>
    `;
}


function renderExistingFiles(files) {

    const groups = {
        MAU_01: "existingFileMau01",
        MAU_05: "existingFileMau05",
        MAU_06: "existingFileMau06",
        MINH_CHUNG: "existingFilesMinhChung"
    };


    Object.values(groups).forEach(id => {

        const element =
            document.getElementById(id);

        if (element) {
            element.innerHTML = "";
        }

    });


    (files || []).forEach(file => {

        const containerId =
            groups[file.loai_file];

        if (!containerId) return;

        const container =
            document.getElementById(
                containerId
            );

        if (!container) return;

        container.insertAdjacentHTML(
            "beforeend",
            `
            <div class="alert alert-light border py-2 mb-2">

                <i class="bi bi-file-earmark me-1"></i>

                ${escapeHtml(
                    file.ten_file
                )}

                <a
                    href="api.php?action=download&id=${file.id}"
                    target="_blank"
                    class="btn btn-sm btn-outline-primary float-end"
                >
                    <i class="bi bi-download"></i>
                </a>

            </div>
            `
        );
    });
}


/* =====================================================
   SAVE
===================================================== */

async function saveForm() {

    if (!validateStep(1)) {

        setStep(1);

        return;
    }


    if (!isOtherCQT && !validateStep(2)) {

        setStep(2);

        return;
    }


    const form =
        document.getElementById(
            "initiativeForm"
        );

    const formData =
        new FormData(form);


    /*
     * Xóa author_ids cũ rồi thêm
     * theo đúng thứ tự.
     */
    formData.delete("author_ids[]");

    if (!isOtherCQT) {

        const ngayNop =
            document.getElementById("ngay_nop")?.value.trim();

        if (ngayNop) {

            const parts =
                ngayNop.split("/");

            if (parts.length === 3) {

                formData.set(
                    "ngay_nop",
                    `${parts[2]}-${parts[1]}-${parts[0]}`
                );
            }
        }

    } else {

        formData.delete("ngay_nop");
    }


    /*
     * Chuyển datetime-local
     * sang format MySQL.
     */
    /*
    * Loại sáng kiến
    */
    formData.set(
        "loai_sang_kien",
        isOtherCQT
            ? "KHAC_CQT"
            : "NOI_BO"
    );


    /*
    * Tên Cơ quan Thuế
    */
    if (isOtherCQT) {

        const tenCoQuanThue =
            document.getElementById("ten_co_quan_thue")?.value.trim();

        formData.set(
            "ten_co_quan_thue",
            tenCoQuanThue || ""
        );

    } else {

        formData.delete("ten_co_quan_thue");
    }


    /*
    * Ngày nộp
    */
    if (!isOtherCQT) {

        const ngayNop =
            document.getElementById("ngay_nop")?.value.trim();

        if (ngayNop) {

            const parts =
                ngayNop.split("/");

            if (parts.length === 3) {

                formData.set(
                    "ngay_nop",
                    `${parts[2]}-${parts[1]}-${parts[0]}`
                );
            }

        }

    } else {

        formData.delete("ngay_nop");
    }


    const button =
        document.getElementById(
            "btnSaveInitiative"
        );

    const oldHtml =
        button.innerHTML;

    button.disabled = true;

    button.innerHTML = `
        <span class="spinner-border spinner-border-sm me-1"></span>
        Đang lưu...
    `;


    try {

        const result =
            await api(
                "save",
                {
                    method: "POST",
                    body: formData
                }
            );

        await Swal.fire({
            icon: "success",
            title: "Đã lưu",
            text:
                result.message ||
                "Lưu sáng kiến thành công.",
            timer: 1800,
            showConfirmButton: false
        });

        initiativeModal.hide();

        /*
         * Nếu app.js cũ có loadDashboard()
         * và loadInitiatives() thì gọi lại.
         */
        if (typeof loadDashboard === "function") {
            loadDashboard();
        }

        if (typeof loadInitiatives === "function") {
            loadInitiatives(
                typeof currentPage !== "undefined"
                    ? currentPage
                    : 1
            );
        }

    } catch (error) {

        Swal.fire({
            icon: "error",
            title: "Không thể lưu",
            text: error.message
        });

    } finally {

        button.disabled = false;
        button.innerHTML = oldHtml;
    }
}