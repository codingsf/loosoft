import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.URL;

import javax.swing.JOptionPane;

import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.util.JRLoader;
public class JRPrinterApplet extends javax.swing.JApplet {
	private URL url = null;
	public void init() {
		String strUrl = getParameter("REPORT_URL");
		if (strUrl != null) {
			try {
				url = new URL(getCodeBase(), strUrl);// �ӻ��html�����л�ñ���URL
				// System.out.println("url=" + url.toURI());//Ҫ��servlet��·��
			} catch (Exception e) {
				StringWriter swriter = new StringWriter();
				PrintWriter pwriter = new PrintWriter(swriter);
				e.printStackTrace(pwriter);
				JOptionPane.showMessageDialog(this, swriter.toString());
			}
		} else {
			JOptionPane.showMessageDialog(this, "Source URL not specified");
		}
	}
	
	public void start() {
		if (url != null) {
			try {
				Object obj = JRLoader.loadObject(url);// ���Ͷ������󣬻��JasperPrint����
				JasperPrintManager.printReport((JasperPrint) obj, true);// ���÷�����ӡ���õ�JasperPrint����
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
