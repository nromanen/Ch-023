package net.carting.dao;

import net.carting.domain.Document;

import java.util.List;

public interface DocumentDAO {

    public List<Document> getAllDocuments();

    public Document getDocumentById(int id);

    public void addDocument(Document document);

    public void updateDocument(Document document);

    public void deleteDocument(Document document);

    public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId, int racerId);

    public boolean isRacerOwnerOfDocument(int documentId);

    public List<Document> gelAllUncheckedDocuments();

}