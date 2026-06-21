//
//  SparklineView.swift
//  TableView
//
//  Created by Rodrigo Takumi on 06/06/26.
//

import UIKit

class SparklineView: UIView {
    
    var dataPoints: [CGFloat] = [] {
        didSet { setNeedsDisplay() }
    }
    
    // Novas propriedades para a Linha de Base
    var baselineValue: CGFloat? {
        didSet { setNeedsDisplay() }
    }
    var baselineColor: UIColor = .systemGray4
    var baselineLineWidth: CGFloat = 0.5
    
    // Configurações da linha do gráfico
    var lineColor: UIColor = .systemBlue
    var lineWidth: CGFloat = 2.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        guard dataPoints.count > 1 else { return }
        guard let maxPoint = dataPoints.max(), let minPoint = dataPoints.min() else { return }
        
        let padding: CGFloat = 2
        let valueRange = maxPoint - minPoint == 0 ? 1 : maxPoint - minPoint
        let heightScale = (rect.height - (padding * 2)) / valueRange
        let widthScale = (rect.width - (padding * 2)) / CGFloat(dataPoints.count - 1)
        
        // --- 2. DESENHAR O GRÁFICO (Sparkline) ---
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        for (index, point) in dataPoints.enumerated() {
            let x = padding + CGFloat(index) * widthScale
            let y = rect.height - padding - (point - minPoint) * heightScale
            
            if index == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        lineColor.setStroke()
        path.stroke()
        
        // --- 1. DESENHAR A BASELINE (Se houver valor definido) ---
        if let baseline = baselineValue {
            let clampedBaseline = max(min(baseline, maxPoint), minPoint)
            let baselineY = rect.height - padding - (clampedBaseline - minPoint) * heightScale
            
            let baselinePath = UIBezierPath()
            baselinePath.move(to: CGPoint(x: padding, y: baselineY))
            baselinePath.addLine(to: CGPoint(x: rect.width - padding, y: baselineY))
            baselinePath.lineWidth = baselineLineWidth
            
            // Sem nenhuma linha de "setLineDash" aqui ela desenha sólida por padrão
            baselineColor.setStroke()
            baselinePath.stroke()
        }
    }
}

//class SparklineView: UIView {
//    // Lista de dados (valores decimais) que serão plotados
//    var dataPoints: [CGFloat] = [] {
//        didSet {
//            setNeedsDisplay() // Força o redesenho da View sempre que os dados mudam
//        }
//    }
//    
//    // Customização visual da linha
//    var lineColor: UIColor = .systemBlue
//    var lineWidth: CGFloat = 2.0
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .clear
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.backgroundColor = .clear
//    }
//    
//    override func draw(_ rect: CGRect) {
//        guard dataPoints.count > 1 else { return }
//        
//        let path = UIBezierPath()
//        path.lineWidth = lineWidth
//        path.lineCapStyle = .round
//        path.lineJoinStyle = .round
//        
//        // Encontra o valor máximo e mínimo para mapear proporcionalmente à View
//        guard let maxPoint = dataPoints.max(), let minPoint = dataPoints.min() else { return }
//        let valueRange = maxPoint - minPoint == 0 ? 1 : maxPoint - minPoint
//        
//        // Fatores de escala com margens de respiro (ex: padding de 2 pontos nas bordas)
//        let padding: CGFloat = 2
//        let widthScale = (rect.width - (padding * 2)) / CGFloat(dataPoints.count - 1)
//        let heightScale = (rect.height - (padding * 2)) / valueRange
//        
//        for (index, point) in dataPoints.enumerated() {
//            // Calcula as coordenadas X e Y coordenando o plano cartesiano invertido do UIKit
//            let x = padding + CGFloat(index) * widthScale
//            let y = rect.height - padding - (point - minPoint) * heightScale
//            
//            if index == 0 {
//                path.move(to: CGPoint(x: x, y: y))
//            } else {
//                path.addLine(to: CGPoint(x: x, y: y))
//            }
//        }
//        
//        lineColor.setStroke()
//        path.stroke()
//    }
//}
