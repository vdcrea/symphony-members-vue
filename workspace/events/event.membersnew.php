<?php

class eventmembersnew extends SectionEvent
{
    public $ROOTELEMENT = 'membersnew';

    public $eParamFILTERS = array(
        'etm-members-activation',
				'member-lock-role',
				'member-lock-activation',
				'xss-fail'
    );

    public static function about()
    {
        return array(
            'name' => 'MembersNew',
            'author' => array(
                'name' => 'Vincent Dupont',
                'website' => 'http://symphony-members-vue:8888',
                'email' => 'vincent@vdcrea.com'),
            'version' => 'Symphony 2.6.7',
            'release-date' => '2016-07-29T16:37:33+00:00',
            'trigger-condition' => 'action[membersnew]'
        );
    }

    public static function getSource()
    {
        return '1';
    }

    public static function allowEditorToParse()
    {
        return true;
    }

    public static function documentation()
    {
        return '
                <h3>Success and Failure XML Examples</h3>
                <p>When saved successfully, the following XML will be returned:</p>
                <pre class="XML"><code>&lt;membersnew result="success" type="create | edit">
    &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/membersnew></code></pre>
                <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned.</p>
                <pre class="XML"><code>&lt;membersnew result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;field-name type="invalid | missing" />
...&lt;/membersnew></code></pre>
                <p>The following is an example of what is returned if any options return an error:</p>
                <pre class="XML"><code>&lt;membersnew result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;filter name="admin-only" status="failed" />
    &lt;filter name="send-email" status="failed">Recipient not found&lt;/filter>
...&lt;/membersnew></code></pre>
                <h3>Example Front-end Form Markup</h3>
                <p>This is an example of the form markup you can use on your frontend:</p>
                <pre class="XML"><code>&lt;form method="post" action="{$current-url}/" enctype="multipart/form-data">
    &lt;input name="MAX_FILE_SIZE" type="hidden" value="5242880" />
    &lt;label>Email
        &lt;input name="fields[email]" type="text" />
    &lt;/label>
    &lt;fieldset>
        &lt;label>Password
            &lt;input name="fields[password][password]" type="password" />
        &lt;/label>
        &lt;label>Password Confirm
            &lt;input name="fields[password][confirm]" type="password" />
        &lt;/label>
    &lt;/fieldset>
    &lt;label>Activation
        &lt;input name="fields[activation]" type="text" />
    &lt;/label>
    &lt;label>Role
        &lt;select name="fields[role]">
            &lt;option value="1">Public&lt;/option>
        &lt;/select>
    &lt;/label>
    &lt;input name="action[membersnew]" type="submit" value="Submit" />
&lt;/form></code></pre>
                <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
                <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
                <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
                <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://symphony-members-vue:8888/success/" /></code></pre>';
    }

    public function load()
    {
        if (isset($_POST['action']['membersnew'])) {
            return $this->__trigger();
        }
    }

}
