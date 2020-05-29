Pod::Spec.new do |s|
    s.name = "Stacking"
    s.version = "2.0.0"
    s.summary = "A scrollable UIStackView."
    s.homepage = "https://github.com/berbschloe/Stacking"
    s.license = "MIT"
    s.author = "Brandon Erbschloe"
    s.platform = :ios, "11.0"
    s.source = { :git => "https://github.com/berbschloe/Stacking.git", :tag => s.version.to_s }
    s.source_files = "Stacking/**/*.{h,m,swift}"
    s.swift_version = "5.0"
end
