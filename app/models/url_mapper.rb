class UrlMapper < ApplicationRecord

  after_create :generate_short_url

  HOST_NAME = "#{ENV["FQDN_#{Rails.env.upcase}_URL"]}"

  def self.sanitized_url(original_url)
    original_url.strip!
    sanitized_url = original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    sanitized_url.slice!(-1) if sanitized_url[-1] == "/"
    # sanitized_url = "http://#{sanitized_url}"
    sanitized_url
  end

  def self.generate_url(original_url)
    sanitized_url = self.sanitized_url(original_url)
    domain = Addressable::URI.parse(original_url).host
    url = self.new

    url.alias = domain
    url.domain = domain
    url.original_url = sanitized_url
    url.save!

    return url
  end

  def generate_short_url
    self.short_url = "#{self.id}#{SecureRandom.hex(6)}"
    self.save!
  end

end
