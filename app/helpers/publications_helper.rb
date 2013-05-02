module PublicationsHelper

  def set_phone(publication)
    if publication.phone == "" || publication.phone.nil?
      if publication.user.phone == "" || publication.user.phone.nil?
        "(No disponible)"
      else
        publication.user.phone
      end
    else
      publication.phone
    end
  end

  def set_name_or_email(publication)
    if publication.user.name == "" || publication.user.name.nil?
      publication.user.email
    else
      publication.user.name
    end
  end

end
