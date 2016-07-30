<?php

class Members_recovery_codeEmailTemplate extends EmailTemplate
{
    public $datasources = Array(
 			'members_notifications',);
    public $layouts = Array(
 			'html' => 'template.html.xsl',
 			'plain' => 'template.plain.xsl',);
    public $subject = 'Reset your {$website-name} password';
    public $reply_to_name = '';
    public $reply_to_email_address = '';
    public $recipients = '<{/data/members-notifications/entry/email}>';
    public $attachments = '';

    public $editable = true;

    public $about = Array(
        'name' => 'Members Recovery Code',
        'version' => '1.0',
        'author' => array(
            'name' => 'Vincent Dupont',
            'website' => 'http://symphony-members-vue:8888',
            'email' => 'vincent@vdcrea.com'
        ),
        'release-date' => '2016-07-29T16:27:07+00:00'
    );
}
