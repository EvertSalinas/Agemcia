class Quotation::QuotationPdf < Prawn::Document
  def initialize(quotation)
    super(top_margin: 50)

    @quotation = quotation
    products_size = @quotation.products.size
    @subtotal = @quotation.calculate_products_total
    @iva = @subtotal * 0.16
    @total = @subtotal + @iva

    create_header
    create_body(products_size)
    create_footer
  end

  private

  def create_header
    y_position = cursor
    fill_color "929292"
    draw_text "Cotizacion", size: 25, :at => [400, 700]
    fill_color "000000"
    draw_text "AGENCIA GEMA EVENTOS", size: 15, style: :bold, :at => [0, 670]
    draw_text "Dardanelos Norte", size: 10, :at => [0, 655]
    draw_text "Monterrey, Nuevo Leon. C.P. 64400", size: 10, :at => [0, 640]
    draw_text "Telefono: 8355-0252", size: 10, :at => [0, 625]

    draw_text "FECHA:", size: 11, style: :bold, :at => [375, 670]
    draw_text "#{Date.current}", size: 10, :at => [425, 670]
    draw_text "Cotizacion #", size: 11, style: :bold, :at => [350, 655]
    draw_text "#{@quotation.id}", size: 10, :at => [425, 655]

    draw_text "Cotizacion para:", size: 11, style: :bold, :at => [0, 600]
    draw_text "Nombre: ", size: 10, :at => [0, 570]
    draw_text "#{@quotation.name}", size: 10, :at => [70, 570]
    draw_text "Compania: ", size: 10, :at => [0, 555]
    draw_text "#{@quotation.company}", size: 10, :at => [70, 555]
    draw_text "Direccion: ", size: 10, :at => [0, 540]
    draw_text "#{@quotation.address}", size: 10, :at => [70, 540]
    draw_text "Telefono: ", size: 10, :at => [0, 525]
    draw_text "#{@quotation.phone}", size: 10, :at => [70, 525]

    draw_text "Fecha de evento:", size: 11, :at => [330, 600]
    draw_text "#{@quotation.event_date}", size: 10, :at => [425, 600]
  end

  def create_body(products_size)
    move_cursor_to 500
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
    #move_down 20
    move_cursor_to 200
    draw_text "El equipo se entrega a pie de banqueta, en caso contrario favor de especificar:", size: 10, :at => [0, cursor]
    move_down 20
    draw_text "Estamos a sus ordenes.", size: 10, :at => [0, cursor]
    move_down 20
    draw_text "GRACIAS!", size: 14, style: :bold, :at => [235, cursor]
    move_down 20
    image './app/assets/images/logo.png', scale: 0.18, :at => [190, cursor]
    move_down 110
    draw_text "Nota: En caso de da;ps y extravios de equipo, el costo del mismo correra a cargo del cliente.", size: 10, :at => [0, cursor]
  end

  def products_table
    data = [["CANTIDAD", 'CONCEPTO', 'PRECIO UNITARIO', 'TOTAL']]
    #raise 'error'
    @quotation.products.each do |p|
      data += [[p.amount,p.concept, '$' + (p.price_cents/100.0).to_s, '$' + ((p.price_cents/100.0)*p.amount).to_s]]
    end
    data += [[]]
  end

  def totals_table
    data = [['Subtotal','$' + @subtotal.to_s]]
    data += [['IVA (16%)','$' + @iva.to_s]]
    data += [['TOTAL','$' + @total.to_s]]
  end

end
