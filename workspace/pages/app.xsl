<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/">
	<html lang="en">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge" />
			<meta name="viewport" content="width=device-width, initial-scale=1" />
			<title><xsl:value-of select="$website-name"/></title>
		    <link rel="stylesheet" href="/workspace/app/static/css/app.css" />
		</head>
		<body>
			<app></app>
			<script src="/workspace/app/static/js/app.js"></script>
	    </body>
	</html>
</xsl:template>

</xsl:stylesheet>
