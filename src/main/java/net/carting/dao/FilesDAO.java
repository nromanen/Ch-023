package net.carting.dao;

import java.io.IOException;

/**
 * Carting
 * Created by manson on 8/10/14.
 */
public interface FilesDAO {

    void uploadAll(String path);

    void downloadAll(String path);

}
