function submitForm(actionUrl, pageNum, amount, type, keyword, boardNo) {
        $("#actionForm").attr("action", actionUrl);
        $("#actionForm > input[name=pageNum]").val(pageNum);
        $("#actionForm > input[name=amount]").val(amount);
        $("#actionForm > input[name=type]").val(type);
        $("#actionForm > input[name=keyword]").val(keyword);

        if (boardNo) {
            $("#actionForm").prepend(`<input type='hidden' name="boardNo" value="\${boardNo}">`);
        }
        

        $("#actionForm").submit();
    }
    
 function updateSortIcons(sort, order) {
    $('.sortable').removeClass('sort-asc sort-desc');
    $('.sortable[data-sort="' + sort + '"]').addClass(order === 'asc' ? 'sort-asc' : 'sort-desc');
}
