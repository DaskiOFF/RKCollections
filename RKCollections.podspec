Pod::Spec.new do |spec|
  spec.name         = "RKCollections"
  spec.version      = "0.0.1"
  spec.summary      = "RKCollections"

  spec.description  = "RKCollections."
  spec.homepage     = "https://github.com/DaskiOFF/RKCollections"
  spec.author       = { "Roman Kotov" => "waydeveloper@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.swift_versions = "5.2"

  spec.source       = { :git => "https://github.com/DaskiOFF/RKCollections.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources", "RKCollections/**/*.{swift}"

end
