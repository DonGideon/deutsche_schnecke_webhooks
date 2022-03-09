class CoronaMaker
  def initialize(fullMessage)
    # corona: FirstName FamilyName Birthday
    @firstName = fullMessage.split[1] || 'Namer'
    @familyName = fullMessage.split[2] || 'HaHatol'
    @birthday = fullMessage.split[3] || '16.03.1988'
    @testDate = "#{Time.now.strftime("%d-%m-%Y")}"
    @testTime = "10:#{rand(10..50)}:#{rand(10..50)}"
    @idNumber = "#{rand(11111111..99999999)}"
  end

  def createPdf
    pdf = CombinePDF.load Rails.root.join "app", "logic", "corona.pdf"

    pdf.pages[0].textbox "#{@testDate}", height: 12, width: 60, y: 685, x: 147, font_size: 11, font: :"Helvetica-Bold", box_color: [256,256,256], text_align: :"left", text_padding: 0
    pdf.pages[0].textbox "#{@testTime}", height: 14, width: 60, y: 670, x: 134, font_size: 11, font: :"Helvetica-Bold", box_color: [256,256,256], text_align: :"left", text_padding: 0
    pdf.pages[0].textbox "#{@familyName}", height: 20, width: 100, y: 606.5, x: 142, font_size: 11, font: :"Helvetica-Bold", box_color: [256,256,256], text_align: :"left", text_padding: 0
    pdf.pages[0].textbox "#{@firstName}", height: 20, width: 80, y: 590, x: 179, font_size: 11, font: :"Helvetica-Bold", box_color: [256,256,256], text_align: :"left", text_padding: 0
    pdf.pages[0].textbox "#{@birthday}", height: 20, width: 70, y: 573.5, x: 186, font_size: 11, font: :"Helvetica-Bold", box_color: [256,256,256], text_align: :"left", text_padding: 0
    pdf.pages[0].textbox "#{@idNumber}", height: 14, width: 70, y: 506, x: 71, font_size: 11, font: :"Helvetica-Bold", box_color: [256,256,256], text_align: :"left", text_padding: 0

    pdf.save Rails.root.join "app", "logic", "testresults.pdf"
  end

  def messageLogic(telegramResponseCreator)
    createPdf()
    telegramResponseCreator.documentResponse(Rails.root.join("app", "logic", "testresults.pdf"))
  end
end
