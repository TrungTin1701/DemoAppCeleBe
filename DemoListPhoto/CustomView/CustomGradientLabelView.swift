import UIKit

public class CustomGradientLabelView: UIView {
    var textInput: String?
    private let gradientLayer = CAGradientLayer()
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        // Call setupLabel to configure the label
    }

    convenience init(text: String, frame: CGRect) {
        self.init(frame: frame)
        self.textInput = text
        self.setupLabel()
        self.setupCustomView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
        setupCustomView()
    }
    
    func setupCustomView(){
        setupShadow()
        clipsToBounds = true
        layer.cornerRadius = 25
        layer.borderWidth  = 3.0
        layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func setupShadow(){
        layer.shadowColor = UIColor(.black).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.opacity = 0.9
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    func setupGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        
        layer.addSublayer(gradientLayer)
    }

    func setupLabel() {
        label.frame = bounds
        label.textAlignment = .center
        label.textColor = .white
        label.text = textInput ?? "Default"
        label.numberOfLines = 0
        addSubview(label)
 
    }


    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        label.frame = bounds
    }
}
