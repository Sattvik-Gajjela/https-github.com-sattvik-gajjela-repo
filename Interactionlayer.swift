import Scenes
import Igis


class InteractionLayer : Layer, KeyDownHandler
{   
    let ball = Ball()
    let paddleLeft = Paddle(rect:Rect(size:Size(width: 10, height: 100)))
    let paddleRight = Paddle(rect:Rect(size:Size(width: 10, height: 100)))
    let paddleTop = Paddle(rect:Rect(size:Size(width: 100,height: 10)))
    let paddleBottom = Paddle(rect:Rect(size:Size(width: 100,height: 10)))

    init()
    {   
        super.init(name:"Interaction")

        insert(entity: ball, at: .front)
        ball.changeVelocity(velocityX: 3, velocityY: 3)

        insert(entity: paddleLeft, at: .front)
        insert(entity: paddleRight, at: .front)
        insert(entity: paddleTop, at: .front)
        insert(entity: paddleBottom, at: .front)
    }

    override func preSetup(canvasSize: Size, canvas: Canvas)
    {   
        paddleLeft.move(to:Point(x: 100, y: 480))
        paddleRight.move(to:Point(x: 1000, y: 1650))
        paddleTop.move(to:Point(x: 500, y: 1400))
        paddleBottom.move(to:Point(x: 500, y: 1000))
        dispatcher.registerKeyDownHandler(handler: self)

    }




    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) -> ()
    {   
        print(key)
        let tlpl = paddleLeft.rectangle.rect.topLeft
        let tlpr = paddleRight.rectangle.rect.topLeft
        let tlpt = paddleTop.rectangle.rect.topLeft
        let tlpo = paddleBottom.rectangle.rect.topLeft
        switch key
        {
        case "w":
            paddleLeft.move(to:Point(x: tlpl.x, y:tlpl.y - 15))
        case "s":
            paddleLeft.move(to:Point(x: tlpl.x, y:tlpl.y + 15))
        case "p":
            paddleRight.move(to:Point(x: tlpr.x, y:tlpr.y - 15))
        case "l":
            paddleRight.move(to:Point(x: tlpr.x, y:tlpr.y + 15))
        case "c":
            paddleBottom.move(to:Point(x: tlpo.x - 15, y:tlpr.y))
        case "v":
            paddleBottom.move(to:Point(x: tlpo.x + 15, y:tlpr.y))
        case "n":
            paddleTop.move(to:Point(x: tlpt.x - 15, y:tlpr.y))
        case "m":
            paddleTop.move(to:Point(x: tlpt.x + 15, y:tlpr.y))
        default:
            break
        }
    }


    func postTearDown()
    {   
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
}
