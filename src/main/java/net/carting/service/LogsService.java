package net.carting.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Carting
 * Created by manson on 8/20/14.
 */
public interface LogsService {

    List getAllLogs();

    List getLogsByDate(Timestamp date);

    List getLogsByPeriod(Timestamp start, Timestamp end);

}
