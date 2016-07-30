<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output
    method="xml"
    omit-xml-declaration="yes"
    encoding="UTF-8"
    indent="yes" />

<xsl:template match="/"><xsl:choose>

    <!-- Member blacklisted -->
    <xsl:when test="data/params/remote-address-blacklisted = 'yes'">{
		"event": {
			"name": "members login info",
			"success": false,
			"messages": [{"message": "Your IP address has been blacklisted."}]
		},
		"user": {
			"logged": false,
			"blacklisted": true,
			"banned": true
		}
	}</xsl:when>

    <!-- Member banned -->
    <xsl:when test="data/params/remote-address-banned = 'yes'">{
		"event": {
			"name": "members login info",
			"success": false,
			"messages": [{"message": "Your IP address has been banned."}]
		},
		"user": {
			"logged": false,
			"blacklisted": false,
			"banned": true
		}
	}</xsl:when>

    <!-- Regenerate Activation Code -->
    <xsl:when test="data/events/members_regenerate_activation_code">{
        "event": {
            "name": "members regenerate activation code",
            "success": <xsl:choose><xsl:when test="data/events/members_regenerate_activation_code/@result = 'success'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "messages": [<xsl:for-each select="data/events/members_regenerate_activation_code/child::node()">
                <xsl:if test="@message!=''">{"message": "<xsl:value-of select="@message"/>"}<xsl:if test="./following-sibling::node()[@message!='']">,</xsl:if></xsl:if>
            </xsl:for-each><xsl:if test="data/events/members_regenerate_activation_code/filter[@name='etm-members-activation']/@status = 'passed'">{"message": "A new activation link as been sent to <xsl:value-of select="data/events/members_regenerate_activation_code/post-values/email"/>"}</xsl:if>]
        }
    }</xsl:when>

    <!-- Reset Password -->
    <xsl:when test="data/events/members_reset_password">{
        "event": {
            "name": "members reset password",
    		"success": <xsl:choose><xsl:when test="data/events/members_reset_password/@result = 'success'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "messages": [<xsl:for-each select="data/events/members_reset_password/child::node()">
                <xsl:if test="@message!=''">{"message": "<xsl:value-of select="@message"/>"}<xsl:if test="./following-sibling::node()[@message!='']">,</xsl:if></xsl:if>
            </xsl:for-each>]
        }
    }</xsl:when>

    <!-- Activate Account -->
    <xsl:when test="data/events/members_activate_account">{
        "event": {
            "name": "members activate account",
    		"success": <xsl:choose><xsl:when test="data/events/members_activate_account/@result = 'success'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "messages": [{"message": "<xsl:value-of select="data/events/members_activate_account/activation/@message"/>"}]
        }
    }</xsl:when>

    <!-- Member Generate Recovey Code -->
    <xsl:when test="data/events/members_generate_recovery_code">{
        "event": {
            "name": "members generate recovery code",
            "success": <xsl:choose><xsl:when test="data/events/members_generate_recovery_code/@result = 'success'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "messages": [<xsl:for-each select="data/events/members_generate_recovery_code/child::node()">
                <xsl:if test="@message!=''">{"message": "<xsl:value-of select="@message"/>"}<xsl:if test="./following-sibling::node()[@message!='']">,</xsl:if></xsl:if>
            </xsl:for-each><xsl:if test="data/events/members_generate_recovery_code/filter[@name='etm-members-recovery-code']/@status = 'passed'">{"message": "A link to reset your password been sent to your mailbox <xsl:value-of select='data/events/members_generate_recovery_code/post-values/email'/>"}</xsl:if>]
        }
    }</xsl:when>

    <!-- Member New -->
    <xsl:when test="data/events/membersnew">{
        "event": {
            "name": "members new",
            "success": <xsl:choose><xsl:when test="data/events/membersnew/@result = 'success'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "messages": [<xsl:for-each select="data/events/membersnew/child::node()">
                <xsl:if test="@message!=''">{"message": "<xsl:value-of select="@message"/>"}<xsl:if test="./following-sibling::node()[@message!='']">,</xsl:if></xsl:if>
            </xsl:for-each><xsl:if test="data/events/membersnew/filter[@name='etm-members-activation']/@status = 'passed'">{"message": "Account successfuly created. A confirmation email as been sent to <xsl:value-of select="data/events/membersnew/post-values/email"/>"}</xsl:if>]
        }
	}</xsl:when>

    <!-- Login -->
    <xsl:when test="data/events/member-login-info/@result !=''">{
        "event": {
            "name": "members login info",
            "success": <xsl:choose><xsl:when test="data/events/member-login-info/@result = 'success'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "messages": [<xsl:for-each select="data/events/member-login-info/child::node()">
                <xsl:if test="@message!=''">{"message": "<xsl:value-of select="@message"/>"}<xsl:if test="./following-sibling::node()[@message!='']">,</xsl:if></xsl:if>
            </xsl:for-each>]
        }<xsl:if test="data/events/member-login-info/@result = 'success'">,
        "user": {
			"logged": true,
			"blacklisted": false,
			"banned": false,
            "id": <xsl:value-of select="data/member/entry/@id"/>,
            "alias": "<xsl:value-of select="data/member/entry/email/@alias"/>",
            "domain": "<xsl:value-of select="data/member/entry/email/@domain"/>",
            "email": "<xsl:value-of select="data/member/entry/email"/>",
            "activated": <xsl:choose><xsl:when test="data/member/entry/activation/@activated = 'yes'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
            "role": "<xsl:value-of select="data/member/entry/role/name/@handle"/>"
        }</xsl:if>
    }</xsl:when>

    <xsl:otherwise>{
        "event": {
            "name": "members login info",
            "success": false
        },
        "user": {
			"logged": false,
			"blacklisted": false,
			"banned": false
		}
    }</xsl:otherwise>

</xsl:choose></xsl:template>

</xsl:stylesheet>
