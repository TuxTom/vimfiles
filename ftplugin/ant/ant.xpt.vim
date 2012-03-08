XPTemplate priority=personal

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common
      \ xml/xml



XPTvar $CURSOR_PH 

XPTvar $CL    <!--
XPTvar $CM
XPTvar $CR      -->
XPTinclude
      \ _comment/doubleSign

" ========================= Function and Variables =============================

fun! s:f.antBoolValue() "{{{
    return s:f.Choose(['true', 'false'])
endfunction "}}}

" ================================= Snippets ===================================

" template for name attribute and optional description attribute (that has a
" sane default for the description value)
XPT nameWithOptionalDesc hidden
XSET description|def=description of _xSnipName() R( 'name' )
name="`name^"` `description={{^ description="`description^"`}}^
..XPT

XPT property " <property name=... />
XSET type|def=Choose(['value', 'location', 'refid'])
<property name="`name^" `type^="`value^" />
`cursor^
..XPT

XPT propfile " <property file=... />
XSET type|def=Choose(['file', 'url', 'resource', 'environment'])
<property `type^="`source^" />
`cursor^
..XPT

" template for import and include
XPT pull_file hidden " <$_xSnipName file=... />
XSET bool|def=antBoolValue()
<`t^$_xSnipName^ file="`file^"` `optional={{^ optional="`bool^"`}}^` `as={{^ as="`prefix^"`}}^ />
`cursor^
..XPT

XPT import alias=pull_file
XPT include alias=pull_file

XPT echo " <echo message=... />
XSET level|def=Choose(['error', 'warning', 'info', 'verbose', 'debug'])
<echo` `level={{^ level="`level^"`}}^ message="`message^" />
`cursor^
..XPT

XPT echol " <echo> | </echo>
XSET level|def=Choose(['error', 'warning', 'info', 'verbose', 'debug'])
<echo` `level={{^ level="`level^"`}}^>` `message` ^<echo/>
`cursor^
..XPT

XPT echoprops " <echopropterties />
<echoproperties` `prefix={{^ prefix="`prefix^"`}}^ />
`cursor^
..XPT

XPT sequential " <sequential> | </sequential>
<sequential>
    `cursor^
</sequential>
..XPT

XPT attribute " <attribute name=... />
<attribute `:nameWithOptionalDesc:^` `default={{^ default="`value^"`}}^ />

..XPT

XPT element " <element name=... />
XSET bool1|def=antBoolValue()
XSET bool2|def=antBoolValue()
<element `:nameWithOptionalDesc:^` `optional={{^ optional="`bool1^"`}}^` `implicit={{^ implicit="`bool2^"`}}^ />

..XPT

XPT macro " <macrodef name=...> | </macrodef>
<macrodef `:nameWithOptionalDesc:^>
    `attribute...^`:attribute:^`attribute...^
    `element...^`:element:^`element...^
    `Include:sequential^
</macrodef>
..XPT

XPT target " <target name=...> | </target>
<target `:nameWithOptionalDesc:^` `depends={{^ depends="`dependencies^"`}}^>
    `cursor^
</target>
..XPT

XPT project " <project name=...> | </project>
XSET description|def=description of project R( 'name' )
<project name="`name^"` `default={{^ default="`defaulttarget^"`}}^` `basedir={{^ basedir="`basedir^"`}}^>
    `<description...>{{^<description>
        `description^
    </description>
    `}}^`cursor^
</project>
..XPT

XPT if " <if> | <then> | </then> [<else> | </else>] </if>
<if>
    `condition^
    <then>
        `then^
    </then>`
    `else...{{^<else>
        `else^
    </else>`}}^
</if>

..XPT

XPT equals " <equals arg1=... />
XSET bool1|def=antBoolValue()
XSET bool2|def=antBoolValue()
<equals arg1="`arg1^" arg2="`arg2^"` `casesensitive={{^ casesensitive="`bool1^"`}}^` `trim={{^ trim="`bool2^"`}}^ /> 
..XPT

XPT fileset " <fileset dir=... />
<fileset dir="`directory^"` `includes={{^ includes="`^"`}}^` `excludes={{^ excludes="`^"`}}^ />

..XPT
