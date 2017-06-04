require 'fastimage'
require 'nokogiri'

module AmpConvert
  def img2amp(input)
    # parse the HTML with nokogiri
    doc = Nokogiri::HTML.fragment(input)
    # find all images
    doc.css('img').each do |img|
      src = img['src']
      if src[0] == '/'
        src = Dir.pwd + src
      end
      size = FastImage.size(src)
      if not img['width']
        img['width'] = size[0]
      end
      if not img['height']
        img['height'] = size[1]
      end
      img.name = 'amp-img'
    end
    doc.to_html
  end
end

Liquid::Template.register_filter(AmpConvert)
