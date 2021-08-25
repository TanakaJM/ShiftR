import UIKit

var str = "Hello, playground"

class Shifter {

    var red: Int = 255
    var green: Int = 0
    var blue: Int = 0
    
    func attach(_ onShift: @escaping (_ red: Int,_ green: Int,_ blue: Int) -> ()) {
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { [self] timer in
            updateColours()
            onShift(red, green, blue)
        }
    }
    
    func updateColours() {
        let colourArray = [red, green, blue]
        
        let getCurrentMax: ([Int]) -> Int = { array in
            var indexOfMax = 0
            var max = 0
            
            array.enumerated().forEach({
                if $0.element > max {
                    indexOfMax = $0.offset
                    max = $0.element
                }
            })
            
            return indexOfMax
        }
        
        let indexOfCurrentMax = getCurrentMax(colourArray)
        
        let previousIndex = indexOfCurrentMax - 1 < 0 ? 2 : indexOfCurrentMax - 1
        let nextIndex = indexOfCurrentMax + 1 > 2 ? 0 : indexOfCurrentMax + 1
        
        if colourArray[previousIndex] > 0 {
            let prevValue = getValueOfColour(at: previousIndex)
            let newValue = prevValue - 1 > 0 ? prevValue - 1 : 0
            updateColour(at: previousIndex, with: newValue)
        } else if colourArray[nextIndex] < 255 {
            let prevValue = getValueOfColour(at: nextIndex)
            let newValue = prevValue + 1 > 255 ? 255 : prevValue + 1
            updateColour(at: nextIndex, with: newValue)
        } else if colourArray[nextIndex] == getValueOfColour(at: indexOfCurrentMax) {
            updateColour(at: indexOfCurrentMax, with: 254)
        } else if colourArray[previousIndex] == getValueOfColour(at: indexOfCurrentMax) {
            updateColour(at: indexOfCurrentMax, with: 254)
        }
    }
    
    private func updateColour(at index: Int, with value: Int) {
        switch index {
        case 0:
            red = value
        case 1:
            green = value
        case 2:
            blue = value
        default:
            print("Tried to update colour at \(index) but no such colour exists")
        }
    }
    
    private func getValueOfColour(at index: Int) -> Int {
        switch index {
        case 0:
            return red
        case 1:
            return green
        case 2:
            return blue
        default:
            print("Tried to get colour at \(index) but no such colour exists")
            return 0
        }
    }
}


let shifter = Shifter()

var rgbSubject = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))

shifter.attach { (red, green, blue) in
    rgbSubject.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
}
