package net.carting.service;

import net.carting.dao.LogsDAO;
import net.carting.domain.Logs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Carting
 * Created by manson on 8/20/14.
 */
@Service
public class LogsServiceImpl implements LogsService {

    @Autowired
    private LogsDAO logsDAO;

    @Override
    @Transactional
    public List<Logs> getAllLogs() {
        return logsDAO.getAllLogs();
    }
}
