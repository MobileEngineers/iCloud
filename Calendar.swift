//
//  Calendar.swift
//  Homework
//
//  Created by Matheus Amancio Seixeiro on 6/19/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import EventKit

struct Calendar {
    
    static func getCalendar() -> EKCalendar? {
        let appDelegate = UIApplication.sharedApplication().delegate
            as? AppDelegate
        let eventStore = appDelegate!.eventStore
        let userdefaults = NSUserDefaults.standardUserDefaults()
        var calendar: EKCalendar?
        
        if let calendarIdentifier = userdefaults.stringForKey("calendarIdentifier") {
            let calendars = eventStore!.calendarsForEntityType(EKEntityTypeEvent)
            for c in calendars {
                if c.calendarIdentifier == calendarIdentifier {
                    calendar = c as? EKCalendar
                    break
                }
            }
        }
        
        
        if calendar == nil {
            calendar = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: eventStore)
            
            calendar!.title = "Avaliações"
            calendar!.CGColor = UIColor.blueColor().CGColor
            calendar!.source = eventStore?.defaultCalendarForNewEvents.source
            
            var error: NSError?
            eventStore!.saveCalendar(calendar, commit: true, error: &error)
            
            if error == nil {
                userdefaults.setObject(calendar!.calendarIdentifier, forKey: "calendarIdentifier")
            } else {
                println("Error: 548294. Description: "+error!.localizedDescription)
            }
            
        }
        return calendar
    }
    
    static func addEvent(title: String, notes: String, date: NSDate) -> EKEvent
    {
        let appDelegate = UIApplication.sharedApplication().delegate
            as? AppDelegate
        let eventStore = appDelegate!.eventStore
        
        var event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = date
        event.endDate = date
        event.notes = notes
        event.calendar = getCalendar()
        
        var error: NSError?
        eventStore!.saveEvent(event, span: EKSpanThisEvent, commit: true, error: &error)
        
        if error != nil {
            println("Error: 832475. Description: "+error!.localizedDescription)
        }
        
        return event
    }
    
    static func removeEvent(identifier: String, error: NSErrorPointer) {
        let appDelegate = UIApplication.sharedApplication().delegate
            as? AppDelegate
        if let eventStore = appDelegate!.eventStore {
            if let event = eventStore.eventWithIdentifier(identifier) {
                eventStore.removeEvent(event, span: EKSpanFutureEvents, commit: true, error: error)
            }
        }
    }
    
    static func Authorization() -> Bool
    {
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent){
            
        case .Authorized:
            println("Authorized")
            return true
        case .Denied:
            println("Denied")
            return false
        case .NotDetermined:
            return false
        case .Restricted:
            println("Restricted")
            return false
        }
    }
    
}