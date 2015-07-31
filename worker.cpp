#include "worker.h"

#include <QDebug>
#include <QImage>
#include <QPainter>
#include <QBrush>
#include <QColor>
#include <QPrinter>
#include <QPrinterInfo>
#include <QImageReader>
#include <QDateTime>

Worker::Worker(QString workingDir, QObject *parent) : QObject(parent)
{
    m_workingDir = workingDir;
}

void Worker::setPaths(QStringList paths)
{
     m_paths = paths;
}

void Worker::work()
{
    if (m_paths.length() != 4) {
        qDebug() << "Not exactly 4 pictures, but we need 4. Abort.";
        return;
    }

    QImage image = createImage();
    printImage(image);
}

/*
 *
 * Postcard:  100 x  148 mm
 *           2000 x 2960 px
 *
 */
QImage Worker::createImage()
{
    qDebug() << "Creating final image:" << m_paths;

    QImage img1(m_paths[0]);
    QImage img2(m_paths[1]);
    QImage img3(m_paths[2]);
    QImage img4(m_paths[3]);

    if (img1.isNull() || img2.isNull() || img3.isNull() || img4.isNull()) {
        qWarning() << "Could not load one of the image files. Abort.";
        return QImage();
    }

    // TODO: This is twice the resulution we need, leaf it?
    int tWidth = 2960;
    int tHeight = 2000;
    int outerBorder = 30;
    int innerBorder = 15;
    innerBorder = innerBorder / 2;
    QColor backgroundColor = QColor::fromRgbF(0.0, 0.0, 0.0);

    QImage targetImage(QSize(tWidth, tHeight), QImage::Format_ARGB32_Premultiplied);

    QRectF targetRect1(outerBorder,            outerBorder,            tWidth/2-outerBorder-innerBorder,  tHeight/2-outerBorder-innerBorder);
    QRectF targetRect2(tWidth/2+innerBorder,   outerBorder,            tWidth/2-outerBorder-innerBorder,  tHeight/2-outerBorder-innerBorder);
    QRectF targetRect3(outerBorder,            tHeight/2+innerBorder,  tWidth/2-outerBorder-innerBorder,  tHeight/2-outerBorder-innerBorder);
    QRectF targetRect4(tWidth/2+innerBorder,   tHeight/2+innerBorder,  tWidth/2-outerBorder-innerBorder,  tHeight/2-outerBorder-innerBorder);

    QPainter p;
    p.begin(&targetImage);
    p.fillRect(targetImage.rect(), QBrush(backgroundColor));
    p.drawImage(targetRect1, img1, img1.rect());
    p.drawImage(targetRect2, img2, img2.rect());
    p.drawImage(targetRect3, img3, img3.rect());
    p.drawImage(targetRect4, img4, img4.rect());
    p.end();

    QDateTime now = QDateTime::currentDateTime().toLocalTime();
    QString nowString = now.toString("yyyyMMdd-HHhhss");
    QString path = m_workingDir + "/fb-" + nowString + ".jpg";
    bool success = targetImage.save(path, "JPEG");

    qDebug() << "Image saved successfully:" << success << path;
    //emit imageReadyForPrint();

    return targetImage;
}

void Worker::printImage(QImage image)
{
    // TODO: Select printer with QPrinterInfo::availablePrinterNames
    // Use name for printer.setName() ... probably...

    qDebug() << "Start print";
    // TODO: Try high res. Without size of page is: 1746x1183 px => about 300 dpi, which should be fine
    QPrinter printer(QPrinter::HighResolution);

    qDebug() << "Printer is valid:" << printer.isValid();
    qDebug() << "Printer name:" << printer.printerName();
    qDebug() << "Printer prog:" << printer.printProgram();

    QStringList pnames = QPrinterInfo::availablePrinterNames();
    qDebug() << "Printers:" << pnames;

    printer.setResolution(300);
    //printer.setPaperSize(QPrinter::Postcard);
    //printer.setPaperSize(QPrinter::A6); // TODO: Maybe this is borderless???
    //printer.setPaperSize(QSizeF(150, 100), QPrinter::Millimeter); // Or this
    printer.setPaperSize(QSizeF(1746*1.1, 1183*1.1), QPrinter::DevicePixel);
    printer.setFullPage(true);
    printer.setOrientation(QPrinter::Landscape);
    printer.setColorMode(QPrinter::Color);

    qDebug() << "Print size:" << printer.paperRect() << "Postcard is/was: 1746x1183";
    qDebug() << "Max phys. size:" << QPrinterInfo(printer).maximumPhysicalPageSize();

    QPainter painter;
    painter.begin(&printer);
    painter.drawImage(printer.paperRect(), image, image.rect());
    painter.end();

    qDebug() << "Send to printer";
    //emit imagePrinted();
}
