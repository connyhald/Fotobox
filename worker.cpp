#include "worker.h"

#include <QDebug>
#include <QImage>
#include <QPainter>
#include <QBrush>
#include <QColor>
#include <QtPrintSupport/QPrinter>

Worker::Worker(QString workingDir, QObject *parent) : QObject(parent)
{
    m_workingDir = workingDir;
}

void Worker::work()
{
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
    qDebug() << "Creating final image";

    QImage img1(m_workingDir + "1.jpg");
    QImage img2(m_workingDir + "2.jpg");
    QImage img3(m_workingDir + "3.jpg");
    QImage img4(m_workingDir + "4.jpg");

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

    bool success = targetImage.save(m_workingDir + "qt-out.jpg", "JPEG");

    qDebug() << "Image created successfully:" << success;
    emit imageReadyForPrint();

    return targetImage;
}

void Worker::printImage(QImage image)
{
    // TODO: Select printer with QPrinterInfo::availablePrinterNames
    // Use name for printer.setName() ... probably...

    qDebug() << "Start print";
    QPrinter printer;
    printer.setResolution(300);
    printer.setPaperSize(QPrinter::Postcard);
    printer.setFullPage(true);
    printer.setOrientation(QPrinter::Landscape);
    printer.setColorMode(QPrinter::Color);

    qDebug() << "Print size:" << printer.paperRect();

    QPainter painter;
    painter.begin(&printer);
    painter.drawImage(printer.paperRect(), image, image.rect());
    painter.end();

    qDebug() << "Send to printer";
    emit imagePrinted();
}
