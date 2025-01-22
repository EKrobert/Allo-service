$(document).ready(function() {
    updatePropositionCount();
  
    $('#add').click(function() {
      var newPropositionIndex = getNewPropositionIndex();
      var newProposition = `
        <div class="form-group">
          <label for="prop${newPropositionIndex}">Proposition ${newPropositionIndex}:</label>
          <div class="input-group">
            <input type="text" name="name[]" placeholder="Proposition ${newPropositionIndex}" class="form-control name_list" required>
            <div class="input-group-append">
              <button type="button" name="remove" class="btn btn-danger btn_remove">X</button>
            </div>
          </div>
        </div>`;
  
      $('#dynamic_field').append(newProposition);
      updatePropositionCount();
      reorderPropositions();
    });
  
    $(document).on('click', '.btn_remove', function() {
      var $inputGroup = $(this).closest('.form-group');
      $inputGroup.remove();
      updatePropositionCount();
      reorderPropositions();
    });
  
    function updatePropositionCount() {
      var propositionCount = $('.name_list').length + 3; // Ajoute 3 pour les 3 propositions initiales
  
      if (propositionCount >= 5) {
        $('#add').hide();
      } else {
        $('#add').show();
      }
  
      $('#proposition_count').text(propositionCount);
    }
  
    function getNewPropositionIndex() {
      return $('.name_list').length + 4; // Ajoute 4 pour commencer à la proposition 4
    }
  
    function reorderPropositions() {
      $('.name_list').each(function(index) {
        var newIndex = index + 4; // Ajoute 4 pour commencer à la proposition 4
        $(this).attr('placeholder', 'Proposition ' + newIndex);
        $(this).closest('.form-group').find('label').text('Proposition ' + newIndex + ':');
      });
  
      var optionsHtml = '';
      var propositionCount = $('.name_list').length + 3;
      if (propositionCount >= 5) {
        $('#add').hide();
      } else {
        $('#add').show();
      }
  
      optionsHtml += '<option value="" selected disabled>Select</option>';
      for (var i = 1; i <= propositionCount; i++) {
        optionsHtml += '<option value="' + i + '">Proposition ' + i + '</option>';
      }
      $('#answer').html(optionsHtml);
    }
  });
  