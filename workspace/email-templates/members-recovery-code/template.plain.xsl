<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes"/>

<xsl:template match="/">
Hello <xsl:value-of select="data/members-notifications/entry/email/@alias"/>,
Here is a link to reset your <xsl:value-of select="$website-name"/> password.
<xsl:value-of select="$root" />/reset-password/<xsl:value-of select="/data/members-notifications/entry/hash" />/<xsl:value-of select="/data/members-notifications/entry/password/recovery-code" />
</xsl:template>
</xsl:stylesheet>
