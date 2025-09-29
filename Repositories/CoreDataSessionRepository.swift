//
//  CoreDataSessionRepository.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import CoreData

class CoreDataSessionRepository: SessionRepositoryProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func add(session: SessionModel) {
        let obj = SessionEntity(context: context)
        obj.sessionId = session.sessionId
        obj.sessionStart = session.sessionStart
        obj.sessionEnd = session.sessionEnd
        save()
    }
    
    func getAllCompleted() -> [SessionModel] {
        let req: NSFetchRequest<SessionEntity> = SessionEntity.fetchRequest()
        req.predicate = NSPredicate(format: "sessionEnd != nil")
        req.sortDescriptors = [NSSortDescriptor(key: #keyPath(SessionEntity.sessionStart), ascending: true)]
        
        let items = (try? context.fetch(req)) ?? []
        
        return items.map(mapToModel(_:))
    }
    
    func getLatest() -> SessionModel? {
        guard let session = fetchLatestManaged() else { return nil }
        return mapToModel(session)
    }
    
    func update(session: SessionModel) {
        guard let session = fetchById(session.sessionId) else { return }
        session.sessionStart = session.sessionStart
        session.sessionEnd = session.sessionEnd
        save()
    }
    
    func removeAllNotActive() {
        let fetch: NSFetchRequest<NSFetchRequestResult> = SessionEntity.fetchRequest()
        fetch.predicate = NSPredicate(format: "sessionEnd == nil")
        
        let deleteReq = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? context.execute(deleteReq)
        context.refreshAllObjects()
    }
    
    // MARK: - private
    
    private func save() {
        guard context.hasChanges else { return }
        do { try context.save() }
        catch { assertionFailure("CoreData save error: \(error)")}
    }
    
    private func mapToModel(_ s: SessionEntity) -> SessionModel {
        SessionModel(
            sessionId: s.sessionId ?? UUID(),
            sessionStart: s.sessionStart ?? Date(),
            sessionEnd: s.sessionEnd
        )
    }
    
    private func fetchLatestManaged() -> SessionEntity? {
        let req: NSFetchRequest<SessionEntity> = SessionEntity.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: #keyPath(SessionEntity.sessionStart), ascending: false)]
        req.fetchLimit = 1
        return try? context.fetch(req).first
    }
    
    private func fetchById(_ id: UUID) -> SessionEntity? {
        let req: NSFetchRequest<SessionEntity> = SessionEntity.fetchRequest()
        req.predicate = NSPredicate(format: "sessionId == %@", id as CVarArg)
        req.fetchLimit = 1
        return try? context.fetch(req).first
    }
}
