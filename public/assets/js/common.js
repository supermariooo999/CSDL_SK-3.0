const tableBody = document.getElementById('ideaTableBody');

const selectedCount =
    document.getElementById('selectedCount');

const checkAll =
    document.getElementById('checkAllIdeas');

const clearButton =
    document.getElementById('btnClearSelection');

const compareButton =
    document.getElementById('btnCompareSelected');


/*
  * Cập nhật số lượng đã chọn
  */

function updateSelectedCount() {

    const checked =
        document.querySelectorAll(
            '.idea-check-item:checked'
        );

    selectedCount.textContent = checked.length;

    /*
      * Highlight dòng được chọn
      */

    document.querySelectorAll('.idea-check-item')
        .forEach(function (checkbox) {

            const row = checkbox.closest('tr');

            if (!row) return;

            if (checkbox.checked) {
                row.classList.add('selected');
            } else {
                row.classList.remove('selected');
            }

        });


    /*
      * Cập nhật checkbox "chọn tất cả"
      */

    const all =
        document.querySelectorAll('.idea-check-item');

    if (all.length === 0) {

        checkAll.checked = false;
        checkAll.indeterminate = false;

        return;
    }

    const checkedCount =
        document.querySelectorAll(
            '.idea-check-item:checked'
        ).length;

    checkAll.checked =
        checkedCount === all.length;

    checkAll.indeterminate =
        checkedCount > 0 &&
        checkedCount < all.length;

}


/*
  * Checkbox từng dòng
  */

tableBody.addEventListener('change', function (e) {

    if (
        e.target.classList.contains(
            'idea-check-item'
        )
    ) {

        updateSelectedCount();

    }

});


/*
  * Chọn tất cả
  */

checkAll.addEventListener('change', function () {

    const checked =
        document.querySelectorAll(
            '.idea-check-item'
        );

    checked.forEach(function (checkbox) {

        checkbox.checked =
            checkAll.checked;

    });

    updateSelectedCount();

});


/*
  * Bỏ chọn tất cả
  */

clearButton.addEventListener('click', function () {

    document.querySelectorAll(
        '.idea-check-item'
    ).forEach(function (checkbox) {

        checkbox.checked = false;

    });

    checkAll.checked = false;
    checkAll.indeterminate = false;

    updateSelectedCount();

});


/*
  * Kiểm tra các sáng kiến được chọn
  */

compareButton.addEventListener('click', function () {

    const selected =
        Array.from(
            document.querySelectorAll(
                '.idea-check-item:checked'
            )
        ).map(function (checkbox) {

            return checkbox.value;

        });


    if (selected.length < 2) {

        alertBox.innerHTML = `
            <div class="alert alert-warning border-0 shadow-sm">
                <i class="bi bi-exclamation-triangle me-2"></i>
                Vui lòng chọn ít nhất <strong>2 sáng kiến</strong>
                để kiểm tra.
            </div>
        `;

        return;

    }


    /*
      * Nếu compare.js có hàm xử lý riêng,
      * có thể gọi tại đây.
      *
      * Ví dụ:
      *
      * compareSelectedIdeas(selected);
      */

    console.log(
        'Các sáng kiến được chọn:',
        selected
    );


    /*
      * Tạm thời hiển thị danh sách ID đã chọn.
      * Sau này kết nối API NLP ở đây.
      */

    alertBox.innerHTML = `
        <div class="alert alert-info border-0 shadow-sm">
            <i class="bi bi-cpu me-2"></i>
            Đang chuẩn bị kiểm tra
            <strong>${selected.length}</strong>
            sáng kiến...
        </div>
    `;

});


/*
  * Hàm này dùng để JS load danh sách.
  *
  * Khi API trả về danh sách sáng kiến,
  * chỉ cần gọi:
  *
  * renderIdeaTable(data);
  */

window.renderIdeaTable = function (ideas) {

    tableBody.innerHTML = '';


    if (!ideas || ideas.length === 0) {

        tableBody.innerHTML = `
            <tr>
                <td colspan="6" class="empty-table">
                    <i class="bi bi-inbox"></i>
                    <div>
                        Không tìm thấy sáng kiến nào.
                    </div>
                </td>
            </tr>
        `;

        updateSelectedCount();

        return;
    }


    ideas.forEach(function (idea) {

        const tr =
            document.createElement('tr');


        /*
          * Hỗ trợ nhiều tên field
          * để dễ ghép với API hiện tại
          */

        const id =
            idea.id ??
            idea.ID ??
            idea.id_sang_kien ??
            '';


        const code =
            idea.ma ??
            idea.ma_sang_kien ??
            idea.code ??
            id;


        const name =
            idea.ten ??
            idea.ten_sang_kien ??
            idea.name ??
            '';


        const field =
            idea.linh_vuc ??
            idea.ten_linh_vuc ??
            idea.field ??
            '';


        const year =
            idea.nam ??
            idea.nam_sang_kien ??
            idea.year ??
            '';


        const status =
            idea.trang_thai ??
            idea.status ??
            '';


        tr.innerHTML = `

            <td class="text-center">

                <input
                    type="checkbox"
                    class="idea-check idea-check-item"
                    value="${escapeHtml(String(id))}"
                >

            </td>


            <td>

                <span class="idea-code">
                    ${escapeHtml(String(code))}
                </span>

            </td>


            <td>

                <div class="idea-name">
                    ${escapeHtml(String(name))}
                </div>

            </td>


            <td>

                <span class="idea-field">
                    ${escapeHtml(String(field))}
                </span>

            </td>


            <td>

                <span class="idea-year">
                    ${escapeHtml(String(year))}
                </span>

            </td>


            <td>

                <span class="status-badge">
                    ${escapeHtml(String(status))}
                </span>

            </td>

        `;


        tableBody.appendChild(tr);

    });


    updateSelectedCount();

};

function resetSelection() {

  document
    .querySelectorAll('.idea-check-item')
    .forEach(cb => {
      cb.checked = false;
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


/*
  * Escape HTML
  */

function escapeHtml(value) {

    return value
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#039;');

}


/*
  * Cho phép JS bên ngoài lấy danh sách
  * ID sáng kiến đang được chọn
  */

window.getSelectedIdeas = function () {

    return Array.from(
        document.querySelectorAll(
            '.idea-check-item:checked'
        )
    ).map(function (checkbox) {

        return checkbox.value;

    });

};

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