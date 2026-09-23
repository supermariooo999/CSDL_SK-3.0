async function editItem(id) {
    try {
        const result = await api(
            `../api/sang-kien-detail.php?id=${encodeURIComponent(id)}`
        );

        // editItem trong add.js fill form
        fillForm(result);

        document.getElementById('initiativeModalTitle')
            .textContent = 'Chỉnh sửa sáng kiến';

        // Hiển thị field CQT / ẩn bước tác giả nếu cần
        resetFormFieldsOnly();

        bootstrap.Modal
            .getOrCreateInstance(document.getElementById('initiativeModal'))
            .show();

    } catch (error) {
        toast(error.message, 'error');
    }
}

window.editItem = editItem;

window.editInitiative = function (id) {
    editItem(id);
};