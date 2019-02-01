Pod::Spec.new do |s|
    s.name = "Stacking"
    s.version = "1.0.0"
    s.summary = "A scrollable UIStackView."
    s.homepage = "https://github.com/berbschloe/Stacking"
    s.license = "MIT"
    s.author = "Brandon Erbschloe"
    s.platform = :ios, "10.0"
    s.source = { :git => "https://github.com/berbschloe/Stacking.git", :tag => "1.0.0" }
    s.source_files = "Stacking/**/*.{h,m,swift}"
    s.swift_version = "4.2"
end
