import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class UpdateProjectDepMain {
   
   private static Map<String, String> projectToVersion;
   private static List<String> filenames;
   
   static {
      projectToVersion = new HashMap<String, String>();
      
      projectToVersion.put("cps_java", "1.3-VCI-SCALABILITY");
      projectToVersion.put("cps_sparkle_java", "1.3-VCI-SCALABILITY");
      projectToVersion.put("cps_verizon_java", "1.3-VCI-SCALABILITY");
      projectToVersion.put("dist_cache_java", "1.1-VCI-SCALABILITY");
      projectToVersion.put("finder_api", "3.22-VCI-SCALABILITY");
      projectToVersion.put("finder_billing", "2.28-VCI-SCALABILITY");
      projectToVersion.put("finder_core", "1.29-VCI-SCALABILITY");
      projectToVersion.put("finder_event_processor", "1.3-VCI-SCALABILITY");
      projectToVersion.put("finder_internal_api", "1.3-VCI-SCALABILITY");
      projectToVersion.put("finder_verizon", "1.3-VCI-SCALABILITY");
      projectToVersion.put("history_store_client_java", "1.3-VCI-SCALABILITY");
      projectToVersion.put("integration_sparkle", "1.14-VCI-SCALABILITY");
      projectToVersion.put("verizon_am", "1.3-VCI-SCALABILITY");
      projectToVersion.put("verizon_mtas", "1.3-VCI-SCALABILITY");
      projectToVersion.put("verizon_revo", "1.3-VCI-SCALABILITY");
      projectToVersion.put("verizon_spg", "1.3-VCI-SCALABILITY");
      projectToVersion.put("verizon_ub_api", "1.2-VCI-SCALABILITY");
      
      filenames = new ArrayList<String>();
      for (Entry<String, String> entry : projectToVersion.entrySet()) {
         filenames.add(entry.getKey() + "/project.xml");
      }
   }

   /**
    * @param args
    */
   public static void main(String[] args) {
      for (String filename : filenames) {
         findNReplace(filename);
      }
   }
   
   private static void findNReplace(String filename) {
      try
      {
         FileReader reader = new FileReader(filename);
         String line = "";
         String oldtext = "";
         StringBuffer sb = new StringBuffer();
         
         char[] buffer = new char[1024];
         int numRead = 0;
         while((numRead = reader.read(buffer)) != -1)
         {
            sb.append(String.valueOf(buffer, 0, numRead));
         }
         reader.close();

         oldtext = sb.toString();
         String newtext = oldtext;
         for (Entry<String, String> entry : projectToVersion.entrySet()) {
              String toReplace = "project=\"" + entry.getKey() + "\" version=\".*\" t";
              String replaceWith = "project=\"" + entry.getKey() + "\" version=\"" + entry.getValue() + "\" t";
              newtext = newtext.replaceAll(toReplace, replaceWith);
              
              toReplace = "name=\"" + entry.getKey() + "\" version=\".*\"";
              replaceWith = "name=\"" + entry.getKey() + "\" version=\"" + entry.getValue() + "\"";
              newtext = newtext.replaceAll(toReplace, replaceWith);
         }

         FileWriter writer = new FileWriter(filename);
         writer.write(newtext);
         writer.close();
      }
      catch (IOException ioe)
      {
         ioe.printStackTrace();
      }
   }

}
