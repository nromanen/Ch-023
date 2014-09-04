package net.carting.service;

import net.carting.dao.LogsDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.Date;
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
    public List getAllLogs() {
        return logsDAO.getAllLogs();
    }

    @Override
    @Transactional
    public List getLogsByDate(Timestamp date) {
        return logsDAO.getLogsByDate(date);
    }

    @Override
    @Transactional
    public List getLogsByPeriod(Timestamp start, Timestamp end) {
        return logsDAO.getLogsByPeriod(start, end);
    }
}
