include ActionView::Helpers::NumberHelper

class Quotation::QuotationPdf < Prawn::Document
  def initialize(quotation, params)
    super(top_margin: 50)

    Prawn::Font::AFM.hide_m17n_warning = true

    @quotation        = quotation
    products_size     = @quotation.products.size
    @subtotal         = @quotation.calculate_products_total
    @iva              = @subtotal * 0.16

    @total = @subtotal + @iva     if @should_include_iva
    @total = @subtotal            unless @should_include_iva

    @should_include_iva = @quotation.with_iva

    create_header
    create_body(products_size)
    create_footer
  end

  private

  def create_header
    move_cursor_to 680
    image './app/assets/images/logo-original.png', scale: 0.18, :at => [0, 750]
    fill_color "929292"
    draw_text "Cotización", size: 25, :at => [400, cursor]
    fill_color "000000"

    datos_de_la_empresa(650)
    id_de_cotizacion(650)
    datos_de_cliente(560)
    fechas_de_logistica(580)

  end

  def datos_de_la_empresa(y_starting_position)
    move_cursor_to y_starting_position

    draw_text "GEMA ELIZABETH VALDEZ GARCIA", size: 10, :at => [0, cursor]
    move_down 15
    draw_text "RFC: VAGG660924819", size: 10, :at => [0, cursor]
    move_down 15
    draw_text "Dardanelos Norte #3120, Colonia Estrella", size: 10, :at => [0, cursor]
    move_down 15
    draw_text "Monterrey, Nuevo León. C.P. 64400", size: 10, :at => [0, cursor]
    move_down 15
    draw_text "Teléfono: 8355-0252", size: 10, :at => [0, cursor]
  end

  def id_de_cotizacion(y_starting_position)
    move_cursor_to y_starting_position

    draw_text "FECHA:", size: 11, style: :bold, :at => [375, cursor]
    draw_text "#{I18n.localize @quotation.elaboration_date}", size: 10, :at => [425, cursor]
    move_down 15
    draw_text "Cotización #", size: 11, style: :bold, :at => [350, cursor]
    draw_text "#{@quotation.id.to_s.rjust(5, "0")}", size: 10, :at => [425, cursor]
  end

  def datos_de_cliente(y_starting_position)
    move_cursor_to y_starting_position

    draw_text "Cotización para:", size: 11, style: :bold, :at => [0, cursor]
    move_down 15
    draw_text "Nombre: ", size: 10, :at => [0, cursor]
    draw_text "#{@quotation.name}", size: 10, :at => [70, cursor]
    move_down 15
    draw_text "Compañía: ", size: 10, :at => [0, cursor]
    draw_text "#{@quotation.company}", size: 10, :at => [70, cursor]
    move_down 15
    draw_text "Dirección: ", size: 10, :at => [0, cursor]
    draw_text "#{@quotation.address}", size: 10, :at => [70, cursor]
    move_down 15
    draw_text "Teléfono: ", size: 10, :at => [0, cursor]
    draw_text "#{@quotation.phone}", size: 10, :at => [70, cursor]
  end

  def fechas_de_logistica(y_starting_position)
    move_cursor_to y_starting_position

    draw_text "Fecha del evento:", size: 11, style: :italic, :at => [330, cursor]
    draw_text "#{I18n.localize @quotation.event_date}", size: 10, :at => [425, cursor]
    move_down 15
    draw_text "Fecha de entrega:", size: 11, style: :italic, :at => [330, cursor]
    draw_text "#{I18n.localize @quotation.deliver_date}", size: 10, :at => [425, cursor]
    move_down 15
    #draw_text "Hora de entrega:", size: 11, style: :italic, :at => [330, cursor]
    #draw_text "#{@quotation.event_time.strftime('%H:%M')} hrs", size: 10, :at => [425, cursor]
    #move_down 20
    draw_text "Fecha de recoger:", size: 11, style: :italic, :at => [330, cursor]
    draw_text "#{I18n.localize @quotation.pickup_date}", size: 10, :at => [425, cursor]
    move_down 15
    #draw_text "Hora de recoger:", size: 11, style: :italic, :at => [330, cursor]
    #draw_text "#{@quotation.pickup_time.strftime('%H:%M')} hrs", size: 10, :at => [425, cursor]
  end

  def create_body(products_size)
    move_cursor_to 450
    table(products_table) do
      row(0).background_color = 'F0F0F0'
      row(0).font_style = :bold
      row(0).size = 9
      row(0).align = :center
      row(1..products_size).borders = [:bottom]
      column(0).width = 90
      column(1).width = 270
      column(2).width = 90
      column(3).width = 90
    end

    table(totals_table, position: 360) do
      column(0).width = 90
      column(1).width = 90
      column(1).background_color = 'F0F0F0'
      column(0).borders = [:right]
    end

  end

  def create_footer
    move_cursor_to 120
    draw_text "El equipo se entrega a pie de banqueta, en caso contrario favor de especificar:", size: 10, :at => [0, cursor]
    move_down 20
    draw_text "Estamos a sus órdenes.", size: 10, :at => [0, cursor]
    move_down 20
    draw_text "¡GRACIAS!", size: 14, style: :bold, :at => [235, cursor]
    move_down 40
    draw_text "AGENCIA GEMA EVENTOS", size: 14, style: :bold, :at => [180, cursor]
    move_down 40
    draw_text "Nota: En caso de daños y extravíos de equipo, el costo del mismo correrá a cargo del cliente.", size: 10, :at => [0, cursor]
  end

  def products_table
    data = [["CANTIDAD", 'CONCEPTO', 'PRECIO UNITARIO', 'TOTAL']]
    #raise 'error'
    @quotation.products.each do |p|
      data += [[p.amount,p.concept, number_to_currency(p.price_cents/100.0), number_to_currency((p.price_cents/100.0)*p.amount)]]
    end
    data += [[]]
  end

  def totals_table
    if @should_include_iva
      data = [['Subtotal',number_to_currency(@subtotal)]]
      data += [['IVA (16%)',number_to_currency(@iva)]]
      data += [['TOTAL',number_to_currency(@total)]]
    else
      data = [['TOTAL',number_to_currency(@total)]]
    end
  end

end
