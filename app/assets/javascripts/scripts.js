$(function() {
    $('.duplicate_album').click(function(e) {
        e.preventDefault();
        var formsOnPage, newNestedForm;
        nestedExchange = $(this).closest('.albums').children('.album').last();
        newNestedForm = $(nestedExchange).clone();
        formsOnPage = parseInt($(nestedExchange).find('.vk_group_albums_album_id input').attr('step')) + 1;
        $(newNestedForm).find('input').each(function() {
            $(this).attr('step', formsOnPage);
            oldId = $(this).attr('id').split('_');
            oldId[4] = formsOnPage;
            $(this).attr('id', oldId.join('_'));
            oldName = $(this).attr('name').split('[');
            oldName[2] = formsOnPage + ']';
            $(this).attr('name', oldName.join('['));
            $(this).val('');
        });
        $(newNestedForm).insertAfter(nestedExchange);
    });

    $('.need_key label').click(function(e) {
        current = $(this).closest('div').children('input').is(':checked');
        if(current == false) {
            $('.key_fields').addClass('visible');
        }
        else {
            $('.key_fields').removeClass('visible');
        }
    });
});