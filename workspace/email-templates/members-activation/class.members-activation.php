<?php

class Members_activationEmailTemplate extends EmailTemplate
{
    public $datasources = Array(
 			'members_notifications',);
    public $layouts = Array(
 			'html' => 'template.html.xsl',
 			'plain' => 'template.plain.xsl',);
    public $subject = 'Welcome to {$website-name}';
    public $reply_to_name = '';
    public $reply_to_email_address = '';
    public $recipients = '<{/data/members-notifications/entry/email}>';
    public $attachments = '';

    public $editable = true;

    public $about = Array(
        'name' => 'Members Activation',
        'version' => '1.0',
        'author' => array(
            'name' => 'Vincent Dupont',
            'website' => 'http://symphony-members-vue:8888',
            'email' => 'vincent@vdcrea.com'
        ),
        'release-date' => '2016-07-29T16:25:14+00:00'
    );
}
