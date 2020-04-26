import 'selectize/dist/js/selectize.min.js';
import 'selectize/dist/css/selectize.css';

const selectize = () => {
  $('.selectize-category').selectize({
    create: function (input, callback) {
      
      $('#category_name').val(input);
      $('#new_category').on('submit', function (e) {
        e.preventDefault();
        $.ajax({
          method: 'POST',
          url: $(this).attr('action'),
          data: $(this).serialize(),
          success: function (response) {
            console.log(response);
          },
        });
      });
    },
    sortField: 'text',
  });
};

export { selectize };
