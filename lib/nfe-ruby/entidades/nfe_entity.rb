#coding: utf-8

module NfeEntity


  def validate
    return true
  end

  def attributes
    die('Método attributes não sobrescrito na entidade')
  end

  def to_nfe_format
    if validate
      xml = ""
      attributes.each_pair do |key, value|
        xml += convert_to_xml(key, value)
      end
      return xml
    end
  end

  private
  def convert_to_xml(key, value)
    if value.nil?
      return ""
    end
    unless value.is_a? Hash
      "<#{key}>#{value}<#{key}/>" unless value.nil?
    else
      <<-XML
        <#{key}>
            hash_converter(value)
        </#{key}>
      XML
    end
  end

  def hash_converter(hash)
    hash.each_pair do |key, value|
      convert_to_xml(key, value)
    end
  end
end
