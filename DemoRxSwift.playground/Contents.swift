import UIKit

import RxSwift
import RxCocoa

let observable1 = Observable.of([1,2,3,4],[11,22,33,44])
let subscribeObservable = observable1.subscribe{ event in
    print("Event \(event)")
    if let element = event.element {
        print("Element is \(element)")
    }
}

subscribeObservable.dispose()
var disposableBag = DisposeBag()
//Second Way
Observable<String>.create { observer in
    observer.onNext("A")
    observer.onNext("B")
    observer.onCompleted()
    observer.onNext("C") //never gets called as completed is called after "B"
    return Disposables.create()
}.subscribe(onNext: { (value) in
    print(value)
}, onError: { (err) in
    print("Error")
}, onCompleted: {
    print("Completed")
}) {
    print("Disposed")
}.disposed(by: disposableBag)