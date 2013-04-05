// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program cv_Canny;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
{$I ..\..\uses_include.inc}
  ;

const
  filename = 'Resource\cat2.jpg';

Var
  image: pIplImage = nil;
  gray: pIplImage = nil;
  dst: pIplImage = nil;

begin
  try
    // �������� ��������
    image := cvLoadImage(filename);
    WriteLn(Format('[i] image: %s', [filename]));

    // ������ ������������� ��������
    gray := cvCreateImage(cvGetSize(image), IPL_DEPTH_8U, 1);
    dst := cvCreateImage(cvGetSize(image), IPL_DEPTH_8U, 1);

    // ���� ��� ����������� ��������
    cvNamedWindow('original', CV_WINDOW_AUTOSIZE);
    cvNamedWindow('gray', CV_WINDOW_AUTOSIZE);
    cvNamedWindow('cvCanny', CV_WINDOW_AUTOSIZE);

    // ����������� � �������� ������
    cvCvtColor(image, gray, CV_RGB2GRAY);

    // �������� �������
    cvCanny(gray, dst, 10, 100, 3);

    // ���������� ��������
    cvShowImage('original', image);
    cvShowImage('gray', gray);
    cvShowImage('cvCanny', dst);

    // ��� ������� �������
    cvWaitKey(0);

    // ����������� �������
    cvReleaseImage(image);
    cvReleaseImage(gray);
    cvReleaseImage(dst);
    // ������� ����
    cvDestroyAllWindows();
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
