const PowerGenerators = {
  init: () => {
    PowerGenerators.handleCalculateFreight();
    PowerGenerators.handleSearchCep();
  },

  handleCalculateFreight: () => {
    $('.open-calculate-freight').click(function(event) {
      event.preventDefault();
      const url = this.href;
      this.blur();
      $.ajax({
        method: 'get',
        url: url,
      }).done(function (data) {
        $('.modal-body').html(data);
        $('#myModal').modal();
        PowerGenerators.init();
      });
    })
  },

  handleSearchCep: () => {
    $('.cep_input').keyup(function(event) {
      event.preventDefault();
      $('.freight-value').html('');
      const cep = $('.cep_input').val();
      if(cep.length === 8){
        $('.cep_input').prop('disabled', true);
        $.ajax({
          method: 'get',
          url: `http://viacep.com.br/ws/${cep}/json/`,
        }).done(function (data) {
          $('.cep_input').prop('disabled', false);
          if(data.erro){
            $('.freight-value').html('CEP inválido');
          } else {
            PowerGenerators.calculateFreight(data.uf)
          }
        }).fail(function(xhr, status, error) {
          $('.cep_input').prop('disabled', false);
          $('.freight-value').html('CEP inválido');
        });
      }
    })
  },

  calculateFreight: (uf) => {
    const powerGeneratorId = $('#power_generator_id').val();
    $.ajax({
      method: 'get',
      url: `/power_generators/${powerGeneratorId}/calculate_freight?uf=${uf}`,
    }).done(function (data) {
      $('.freight-value').html(data.value);
    });
  },

  handleSearch: () => {
    $('#simple-search').keyup(function() {
      PowerGenerators.list();
    });
    $('.search-input').change(function() {
      PowerGenerators.list();
    })
  },

  list: () => {
    const search = $('#simple-search').val();
    const manufacturer_eq = $('#power_generator_manufacturer_eq').val();
    const structure_type_eq = $('#power_generator_structure_type_eq').val();
    const order_by = $('#power_generator_order_by').val();
    $.ajax({
      method: 'get',
      url: 'power_generators/list',
      data: { q: { 
        name_or_description_or_manufacturer_cont: search,
        manufacturer_eq: manufacturer_eq,
        structure_type_eq: structure_type_eq,
      }, order_by: order_by},
    }).done(function (data) {
      $('.container').html(data);
      PowerGenerators.init();
    });
  },

  clearSearch: () => {
    $('#simple-search').val('');
    PowerGenerators.list();
  }
}

$(document).ready(function() {
  PowerGenerators.init();
  PowerGenerators.list();
  PowerGenerators.handleSearch();
});
