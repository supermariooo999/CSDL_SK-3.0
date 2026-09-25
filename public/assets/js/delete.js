// assets/js/delete.js

async function deleteInitiative(id, code) {
    if (!id || id <= 0) {
        toast('ID sáng kiến không hợp lệ', 'error');
        return;
    }

    const confirm = await Swal.fire({
        icon: 'warning',
        title: 'Xoá sáng kiến?',
        html: `
            Bạn có chắc muốn xoá sáng kiến
            <strong>${escapeHtml(String(code || '#' + id))}</strong>?
            <br>
            <small class="text-muted">
                Toàn bộ file đính kèm (Mẫu 01, 05, 06, minh chứng)
                cũng sẽ bị xoá vĩnh viễn.
            </small>
        `,
        showCancelButton: true,
        confirmButtonText: 'Xoá',
        cancelButtonText: 'Huỷ',
        confirmButtonColor: '#dc2626',
        reverseButtons: true,
    });

    if (!confirm.isConfirmed) return;

    try {
        const result = await api('api/sang-kien-delete.php', {
            method: 'POST',
            body: { id },
        });

        if (typeof loadSangKien === 'function') {
            await loadSangKien();
        }

        await Swal.fire({
            icon: 'success',
            title: 'Đã xoá',
            text: result.message || 'Xoá sáng kiến thành công.',
            timer: 1600,
            showConfirmButton: false,
        });

        // Load lại danh sách
        if (typeof loadSangKien === 'function') {
            await loadSangKien();
        }

    } catch (error) {
        Swal.fire({
            icon: 'error',
            title: 'Không thể xoá',
            text: error.message || 'Lỗi không xác định',
        });
    }
}

window.deleteInitiative = deleteInitiative;