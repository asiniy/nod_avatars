Fabricator(:photo) do
  username { Faker::Name.name }
  provider_name { %w(vk fb ok).sample }

  provider_uid do |attrs|
    case attrs[:provider_name]
    when 'vk' then rand(10000..100000)
    when 'fb' then rand(100000000000000..100000005000000)
    when 'ok' then %w(
        529119938935 514276188336 498072201301 524236553491 440195064024
        465611543707 340704330650 558339340267 533542663373 531479491813
        518289681413 353798787894 554427501802 540564452086 559919085730
        125873896002 571860215331 505769941648 468571838628 271570719777
        524440008484 360045720719 527320775770 539556367351 535030462967
      ).sample
    end
  end

  avatar do
    photo = Dir["#{Rails.root}/spec/fabricators/photo_avatars/*.jpg"].sample
    File.open(photo)
  end
end
