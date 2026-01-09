# frozen_string_literal: true

module ApplicationHelper
  def load_pack(page)
    render("shared/pack_setup", page:)
  end

  def s3_bucket_url
    "#{AWS_S3_ENDPOINT}/#{S3_BUCKET}"
  end

  def default_footer_content
    safe_join(
      [
        "Powered by",
        logo_tag(aria: { label: "Gumroad" })
      ],
      " "
    )
  end

  def current_user_props(current_user, impersonated_user)
    {
      name: current_user.display_name,
      avatar_url: current_user.avatar_url,
      impersonated_user: impersonated_user.present? ? {
        name: impersonated_user.display_name,
        avatar_url: impersonated_user.avatar_url
      } : nil
    }
  end

  def number_to_si(number)
    number_to_human(
      number,
      units: { unit: "", thousand: "K", million: "M", billion: "B", trillion: "T" },
      precision: 1,
      significant: false,
      round_mode: :truncate,
      format: "%n%u"
    )
  end
  def icon_tag(name, klass: nil, **options)
    mask_image = "url('#{image_path("icons/#{name}.svg")}')"
    styles = "mask: #{mask_image} center / 120% no-repeat; -webkit-mask: #{mask_image} center / 120% no-repeat;"

    options[:style] = [options[:style], styles].compact.join(";")

    tag.span(
      nil,
      class: class_names("inline-block bg-current shrink-0 align-middle w-[1em] min-h-[max(1lh,1em)]", klass),
      **options
    )
  end

  def logo_tag(variant: "full", klass: nil, **options)
    if variant == "g"
      tag.span(
        nil,
        class: class_names("block bg-contain bg-no-repeat w-[--big-icon-size] h-[--big-icon-size]", klass),
        style: [options[:style], "background-image: url('#{image_path('logo-g.svg')}')"].compact.join(";"),
        **options
      )
    else
      mask_image = "url('#{image_path('logo.svg')}')"
      styles = "width: 7.1428em; min-height: max(1lh, 1em); mask: #{mask_image} center / contain no-repeat; -webkit-mask: #{mask_image} center / contain no-repeat;"

      tag.span(
        nil,
        class: class_names("inline-block bg-current shrink-0", klass),
        style: [options[:style], styles].compact.join(";"),
        **options
      )
    end
  end
end
